from pathlib import Path

import pandas as pd

from tables.util.Utility import format_program_name, format_scientific, get_result_dir


class AnalysisResultTable:
    analysis_directory = Path("../../data/device01/analysis")
    result_directory = get_result_dir()

    def create_latex_row(self, row: pd.Series) -> str:
        values = [
            format_program_name(str(row["Program"])),
            format_scientific(row["Legacy"]),
            format_scientific(row["Monolithic"]),
            format_scientific(row["Clustered"]),
        ]

        return " & ".join(values) + r" \\"

    def create_table(self, dataframe):
        column_format = (
            "@{}l"
            "S[table-format=1.3e-2]"
            "S[table-format=1.3e-2]"
            "S[table-format=1.3e-2]"
            "@{}"
        )

        latex_rows = []

        for _, row in dataframe.iterrows():
            if row["Program"] == "Min":
                latex_rows.append(r"\midrule")

            latex_rows.append(self.create_latex_row(row))

        table_rows = "\n".join(latex_rows)

        latex_table = rf"""\begin{{longtable}}{{{column_format}}}
        \label{{tab:program_energy}} \\

        \toprule
        Program &
        \multicolumn{{1}}{{c}}{{Legacy}} &
        \multicolumn{{1}}{{c}}{{Monolithic}} &
        \multicolumn{{1}}{{c}}{{Clustered}} \\
        \midrule
        \endfirsthead

        \toprule
        Program &
        \multicolumn{{1}}{{c}}{{Legacy}} &
        \multicolumn{{1}}{{c}}{{Monolithic}} &
        \multicolumn{{1}}{{c}}{{Clustered}} \\
        \midrule
        \endhead

        \midrule
        \multicolumn{{4}}{{r}}{{Continued on next page}} \\
        \endfoot

        \bottomrule
        \caption{{Energy of the \texttt{{main}} function for each evaluation
        program. The last two rows shows the minimum and maximum value over all
        programs for the respective method. All values in Joule.}}
        \endlastfoot

        {table_rows}

        \end{{longtable}}
        """

        return latex_table

    def generate(self):
        analysis_rows = []

        analysis_order = ["legacy", "monolithic", "clustered"]

        for csv_path in sorted(self.analysis_directory.glob("*_summary.csv")):
            summary_dataframe = pd.read_csv(csv_path)

            program_name = csv_path.stem.removesuffix("_summary").removesuffix("_analysis")

            energy_values = {
                "Program": program_name,
            }

            for analysis_name in analysis_order:
                matching_rows = summary_dataframe[
                    summary_dataframe["analysis"] == analysis_name
                ]

                if matching_rows.empty:
                    energy_values[analysis_name.capitalize()] = None
                else:
                    energy_values[analysis_name.capitalize()] = matching_rows.iloc[0]["main_energy"]

            analysis_rows.append(energy_values)

        energy_dataframe = pd.DataFrame(analysis_rows)

        energy_dataframe = energy_dataframe[
            ["Program", "Legacy", "Monolithic", "Clustered"]
        ]

        minimum_row = {
            "Program": "Min",
            "Legacy": energy_dataframe["Legacy"].min(),
            "Monolithic": energy_dataframe["Monolithic"].min(),
            "Clustered": energy_dataframe["Clustered"].min(),
        }

        maximum_row = {
            "Program": "Max",
            "Legacy": energy_dataframe["Legacy"].max(),
            "Monolithic": energy_dataframe["Monolithic"].max(),
            "Clustered": energy_dataframe["Clustered"].max(),
        }

        energy_dataframe = pd.concat(
            [
                energy_dataframe,
                pd.DataFrame([minimum_row, maximum_row]),
            ],
            ignore_index=True,
        )

        output_csv_path = self.result_directory / "program_energy.csv"
        energy_dataframe.to_csv(output_csv_path, index=False)

        latex_table = self.create_table(energy_dataframe)

        output_tex_path = self.result_directory / "program_energy.tex"

        with open(output_tex_path, "w", encoding="utf-8") as file:
            file.write(latex_table)

        print(f"Saved CSV to {output_csv_path}")
        print(f"Saved LaTeX table to {output_tex_path}")

