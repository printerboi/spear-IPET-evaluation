from pathlib import Path
import math

from tables.util.Programs import get_selected_programs
from tables.util.Utility import format_scientific, format_program_name, calculate_magnitude_difference, get_result_dir

import pandas as pd

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


    def read_analysis_energy(self, program_name: str, analysis_name: str) -> float | None:
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

    def generate_dataframe(self):
        comparison_rows = []

        for program_index, program_name in enumerate(self.program_names):
            measurement = self.read_measurement_energy(program_index)
            legacy = self.read_analysis_energy(program_name, "legacy")
            clustered = self.read_analysis_energy(program_name, "clustered")

            comparison_rows.append({
                "Program": program_name,
                "Measurement": measurement,
                "Legacy": legacy,
                "Legacy Magnitude Difference": calculate_magnitude_difference(measurement, legacy),
                "Clustered": clustered,
                "Clustered Magnitude Difference": calculate_magnitude_difference(measurement, clustered),
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

        return comparison_dataframe

    def generate_table(self, dataframe):
        column_format = (
            "@{}l"
            "S[table-format=1.3e-2]"
            "S[table-format=1.3e-2]"
            "S[table-format=2.2]"
            "S[table-format=1.3e-2]"
            "S[table-format=2.2]"
            "@{}"
        )

        table_rows = "\n".join(
            self.create_latex_row(row)
            for _, row in dataframe.iterrows()
        )

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
        \caption{{Order of magnitude difference between analysis results and measured energy for device D5}}
        \endlastfoot

        {table_rows}

        \end{{longtable}}
        """

        return (latex_table)

    def generate(self):
        output_csv_path = self.result_directory / f"device0{device_index}_analysis_vs_measurement_magnitude_difference.csv"
        comparison_dataframe = self.generate_dataframe()
        comparison_dataframe.to_csv(output_csv_path, index=False)

        (latex_table) = self.generate_table(comparison_dataframe)

        output_tex_path = self.result_directory / f"device0{device_index}_analysis_vs_measurement_magnitude_difference.tex"

        with open(output_tex_path, "w", encoding="utf-8") as file:
            file.write(latex_table)

        print(f"Saved CSV to {output_csv_path}")
        print(f"Saved LaTeX table to {output_tex_path}")