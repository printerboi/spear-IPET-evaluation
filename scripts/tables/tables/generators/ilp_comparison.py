from pathlib import Path

import pandas as pd

from tables.util.Utility import format_integer, format_program_name, get_result_dir
from tables.util.Programs import get_selected_programs

device_index = 1

class ILPComparisonTable:
    analysis_directory = Path(f"../../data/device0{device_index}/analysis/raw")
    program_names = get_selected_programs()
    result_directory = get_result_dir()

    def read_analysis_json(self, json_path: Path) -> dict | None:
        if not json_path.exists():
            return None

        return pd.read_json(json_path, typ="series").to_dict()


    def summarize_main_ilps(self, analysis_json: dict | None) -> dict[str, int]:
        if analysis_json is None:
            return {
                "ILPs": 0,
                "Constraints": 0,
                "Variables": 0,
            }

        main_function = analysis_json.get("functions", {}).get("main")

        if main_function is None:
            return {
                "ILPs": 0,
                "Constraints": 0,
                "Variables": 0,
            }

        ilps = main_function.get("ILPS", [])

        return {
            "ILPs": len(ilps),
            "Constraints": sum(ilp.get("numConstrains", 0) for ilp in ilps),
            "Variables": sum(ilp.get("numVariables", 0) for ilp in ilps),
        }
    
    def create_constraint_latex_row(self, row: pd.Series) -> str:
        values = [
            format_program_name(str(row["Program"])),
            format_integer(row["Monolithic ILPs"]),
            format_integer(row["Clustered ILPs"]),
            format_integer(row["Monolithic Constraints"]),
            format_integer(row["Clustered Constraints"]),
        ]

        return " & ".join(values) + r" \\"


    def create_variable_latex_row(self, row: pd.Series) -> str:
        values = [
            format_program_name(str(row["Program"])),
            format_integer(row["Monolithic ILPs"]),
            format_integer(row["Clustered ILPs"]),
            format_integer(row["Monolithic Variables"]),
            format_integer(row["Clustered Variables"]),
        ]

        return " & ".join(values) + r" \\"


    def generate_dataframe(self):
        comparison_rows = []

        for program_name in self.program_names:
            clustered_json_path = self.analysis_directory / f"{program_name}_clustered_000.json"
            monolithic_json_path = self.analysis_directory / f"{program_name}_monolithic_000.json"

            clustered_json = self.read_analysis_json(clustered_json_path)
            monolithic_json = self.read_analysis_json(monolithic_json_path)

            clustered_summary = self.summarize_main_ilps(clustered_json)
            monolithic_summary = self.summarize_main_ilps(monolithic_json)

            comparison_rows.append({
                "Program": program_name,
                "Monolithic ILPs": monolithic_summary["ILPs"],
                "Clustered ILPs": clustered_summary["ILPs"],
                "Monolithic Constraints": monolithic_summary["Constraints"],
                "Clustered Constraints": clustered_summary["Constraints"],
                "Monolithic Variables": monolithic_summary["Variables"],
                "Clustered Variables": clustered_summary["Variables"],
            })

        comparison_dataframe = pd.DataFrame(comparison_rows)

        comparison_dataframe = comparison_dataframe.sort_values(
            by="Program",
            ascending=True,
        ).reset_index(drop=True)

        return comparison_dataframe


    def generate_table(self, dataframe):
        constraint_column_format = (
            "@{}l"
            "S[table-format=3.0]"
            "S[table-format=3.0]"
            "S[table-format=5.0]"
            "S[table-format=5.0]"
            "@{}"
        )

        constraint_table_rows = "\n".join(
            self.create_constraint_latex_row(row)
            for _, row in dataframe.iterrows()
        )

        constraint_latex_table = rf"""\begin{{longtable}}{{{constraint_column_format}}}
        \label{{tab:device01_main_ilp_constraints}} \\

        \toprule
        Program &
        \multicolumn{{1}}{{c}}{{Mono. ILPs}} &
        \multicolumn{{1}}{{c}}{{Clust. ILPs}} &
        \multicolumn{{1}}{{c}}{{Mono. constr.}} &
        \multicolumn{{1}}{{c}}{{Clust. constr.}} \\
        \midrule
        \endfirsthead

        \toprule
        Program &
        \multicolumn{{1}}{{c}}{{Mono. ILPs}} &
        \multicolumn{{1}}{{c}}{{Clust. ILPs}} &
        \multicolumn{{1}}{{c}}{{Mono. constr.}} &
        \multicolumn{{1}}{{c}}{{Clust. constr.}} \\
        \midrule
        \endhead

        \midrule
        \multicolumn{{5}}{{r}}{{Continued on next page}} \\
        \endfoot

        \bottomrule
        \caption{{Number of constraints generated for the \texttt{{main}} function on device D1}}
        \endlastfoot

        {constraint_table_rows}

        \end{{longtable}}
        """

        variable_column_format = (
            "@{}l"
            "S[table-format=3.0]"
            "S[table-format=3.0]"
            "S[table-format=5.0]"
            "S[table-format=5.0]"
            "@{}"
        )

        variable_table_rows = "\n".join(
            self.create_variable_latex_row(row)
            for _, row in dataframe.iterrows()
        )

        variable_latex_table = rf"""\begin{{longtable}}{{{variable_column_format}}}
        \label{{tab:device01_main_ilp_variables}} \\

        \toprule
        Program &
        \multicolumn{{1}}{{c}}{{Mono. ILPs}} &
        \multicolumn{{1}}{{c}}{{Clust. ILPs}} &
        \multicolumn{{1}}{{c}}{{Mono. vars.}} &
        \multicolumn{{1}}{{c}}{{Clust. vars.}} \\
        \midrule
        \endfirsthead

        \toprule
        Program &
        \multicolumn{{1}}{{c}}{{Mono. ILPs}} &
        \multicolumn{{1}}{{c}}{{Clust. ILPs}} &
        \multicolumn{{1}}{{c}}{{Mono. vars.}} &
        \multicolumn{{1}}{{c}}{{Clust. vars.}} \\
        \midrule
        \endhead

        \midrule
        \multicolumn{{5}}{{r}}{{Continued on next page}} \\
        \endfoot

        \bottomrule
        \caption{{Number of variables generated for the \texttt{{main}} function on device D1}}
        \endlastfoot

        {variable_table_rows}

        \end{{longtable}}
        """

        return (constraint_latex_table, variable_latex_table)


    def generate(self):
        output_csv_path = self.result_directory / "device01_main_ilp_complexity.csv"
        comparison_dataframe = self.generate_dataframe()
        comparison_dataframe.to_csv(output_csv_path, index=False)

        (constraint_latex_table, variable_latex_table) = self.generate_table(comparison_dataframe)

        constraint_output_tex_path = self.result_directory / "device01_main_ilp_constraints.tex"
        with open(constraint_output_tex_path, "w", encoding="utf-8") as file:
            file.write(constraint_latex_table)

        variable_output_tex_path = self.result_directory / "device01_main_ilp_variables.tex"

        with open(variable_output_tex_path, "w", encoding="utf-8") as file:
            file.write(variable_latex_table)

        print(f"Saved CSV to {output_csv_path}")
        print(f"Saved LaTeX table to {constraint_output_tex_path}")
        print(f"Saved LaTeX table to {variable_output_tex_path}")







