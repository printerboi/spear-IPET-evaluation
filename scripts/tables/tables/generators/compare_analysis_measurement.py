from pathlib import Path

import pandas as pd

from tables.util.Programs import get_selected_programs, get_id
from tables.util.Utility import (
    calculate_magnitude_difference,
    format_program_name,
    format_scientific,
    get_result_dir,
)

device_index = 5


class AnalysisComparisonTable:
    program_names = get_selected_programs()
    result_directory = get_result_dir()

    def read_measurement_energy(self, program_index: int) -> float | None:
        statistics_path = Path(
            f"../../data/device0{device_index}/measurements/raw/{program_index}/statistics.csv"
        )

        if not statistics_path.exists():
            return None

        statistics_dataframe = pd.read_csv(statistics_path)

        mean_row = statistics_dataframe[
            statistics_dataframe["# Value"] == "mean"
        ]

        if mean_row.empty:
            return None

        return mean_row.iloc[0]["Energy"]

    def read_analysis_energy(
        self,
        program_name: str,
        analysis_name: str,
    ) -> float | None:
        summary_path = Path(
            f"../../data/device0{device_index}/analysis/{program_name}_summary.csv"
        )

        if not summary_path.exists():
            summary_path = Path(
                f"../../data/device0{device_index}/analysis/{program_name}_analysis_summary.csv"
            )

        if not summary_path.exists():
            return None

        summary_dataframe = pd.read_csv(summary_path)

        analysis_row = summary_dataframe[
            summary_dataframe["analysis"] == analysis_name
        ]

        if analysis_row.empty:
            return None

        return analysis_row.iloc[0]["main_energy"]

    def create_latex_row(self, row: pd.Series) -> str:
        values = [
            format_program_name(str(row["Program"])),
            format_scientific(row["Measurement"]),
            format_scientific(row["Legacy"]),
            format_scientific(row["Legacy Magnitude Difference"]),
            format_scientific(row["Clustered"]),
            format_scientific(row["Clustered Magnitude Difference"]),
        ]

        return " & ".join(values) + r" \\"

    def add_summary_rows(
        self,
        comparison_dataframe: pd.DataFrame,
    ) -> pd.DataFrame:
        numeric_columns = [
            "Measurement",
            "Legacy",
            "Legacy Magnitude Difference",
            "Clustered",
            "Clustered Magnitude Difference",
        ]

        minimum_row = {"Program": "Min"}
        median_row = {"Program": "Median"}
        maximum_row = {"Program": "Max"}

        for column_name in numeric_columns:
            minimum_row[column_name] = comparison_dataframe[column_name].min()
            median_row[column_name] = comparison_dataframe[column_name].median()
            maximum_row[column_name] = comparison_dataframe[column_name].max()

        return pd.concat(
            [
                comparison_dataframe,
                pd.DataFrame(
                    [
                        minimum_row,
                        median_row,
                        maximum_row,
                    ]
                ),
            ],
            ignore_index=True,
        )

    def generate_dataframe(self) -> pd.DataFrame:
        comparison_rows = []

        for program_name in sorted(self.program_names):
            program_index = get_id(program_name)

            measurement = self.read_measurement_energy(program_index)
            legacy = self.read_analysis_energy(program_name, "legacy")
            clustered = self.read_analysis_energy(program_name, "clustered")

            comparison_rows.append({
                "Program": program_name,
                "Measurement": measurement,
                "Legacy": legacy,
                "Legacy Magnitude Difference": calculate_magnitude_difference(
                    measurement,
                    legacy,
                ),
                "Clustered": clustered,
                "Clustered Magnitude Difference": calculate_magnitude_difference(
                    measurement,
                    clustered,
                ),
            })

        comparison_dataframe = pd.DataFrame(comparison_rows)

        comparison_dataframe = comparison_dataframe[
            [
                "Program",
                "Measurement",
                "Legacy",
                "Legacy Magnitude Difference",
                "Clustered",
                "Clustered Magnitude Difference",
            ]
        ]

        return self.add_summary_rows(comparison_dataframe)

    def generate_table(self, dataframe: pd.DataFrame) -> str:

        column_format = (
            "@{}l"
            "S[table-format=1.3e-2]"
            "S[table-format=1.3e-2]"
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
        \label{{tab:device05_analysis_vs_measurement_magnitude_difference}} \\

        \toprule
        Program &
        \multicolumn{{1}}{{c}}{{Measurement}} &
        \multicolumn{{1}}{{c}}{{Legacy}} &
        \multicolumn{{1}}{{c}}{{Legacy mag.}} &
        \multicolumn{{1}}{{c}}{{Clustered}} &
        \multicolumn{{1}}{{c}}{{Clustered mag.}} \\
        \midrule
        \endfirsthead

        \toprule
        Program &
        \multicolumn{{1}}{{c}}{{Measurement}} &
        \multicolumn{{1}}{{c}}{{Legacy}} &
        \multicolumn{{1}}{{c}}{{Legacy mag.}} &
        \multicolumn{{1}}{{c}}{{Clustered}} &
        \multicolumn{{1}}{{c}}{{Clustered mag.}} \\
        \midrule
        \endhead

        \midrule
        \multicolumn{{6}}{{r}}{{Continued on next page}} \\
        \endfoot

        \bottomrule
        \caption{{Order of magnitude difference between analysis results and
        measured mean energy for device D5. The summary rows show the minimum,
        median, and maximum values over all programs.}}
        \endlastfoot

        {table_rows}

        \end{{longtable}}
        """

        return latex_table

    def generate(self):
        output_csv_path = (
            self.result_directory
            / f"device0{device_index}_analysis_vs_measurement_magnitude_difference.csv"
        )

        comparison_dataframe = self.generate_dataframe()
        comparison_dataframe.to_csv(output_csv_path, index=False)

        latex_table = self.generate_table(comparison_dataframe)

        output_tex_path = (
            self.result_directory
            / f"device0{device_index}_analysis_vs_measurement_magnitude_difference.tex"
        )

        with open(output_tex_path, "w", encoding="utf-8") as file:
            file.write(latex_table)

        print(f"Saved CSV to {output_csv_path}")
        print(f"Saved LaTeX table to {output_tex_path}")
