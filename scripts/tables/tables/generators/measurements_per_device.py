from pathlib import Path

import pandas as pd

from tables.util.Programs import program_names
from tables.util.Utility import format_scientific, get_result_dir


class MeasurementPerDeviceTable:
    result_directory = get_result_dir()

    def format_missing_scientific(self, value: float) -> str:
        if pd.isna(value):
            return "--"

        return format_scientific(value)

    def escape_latex(self, text: str) -> str:
        return text.replace("_", r"\_")

    def format_program_name(self, program_name: str) -> str:
        return rf"\texttt{{{self.escape_latex(program_name)}}}"

    def create_latex_row(self, row: pd.Series) -> str:
        values = [
            self.format_program_name(str(row["Program"])),
            self.format_missing_scientific(row["D1"]),
            self.format_missing_scientific(row["D2"]),
            self.format_missing_scientific(row["D3"]),
            self.format_missing_scientific(row["D4"]),
            self.format_missing_scientific(row["D5"]),
        ]

        return " & ".join(values) + r" \\"

    def create_table(self, measurement_dataframe: pd.DataFrame) -> str:
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

        for _, row in measurement_dataframe.iterrows():
            if row["Program"] == "Min":
                latex_rows.append(r"\midrule")

            latex_rows.append(self.create_latex_row(row))

        table_rows = "\n".join(latex_rows)

        return rf"""\begin{{longtable}}{{{column_format}}}
\label{{tab:measured_energy_per_device}} \\

\toprule
Program &
\multicolumn{{1}}{{c}}{{D1}} &
\multicolumn{{1}}{{c}}{{D2}} &
\multicolumn{{1}}{{c}}{{D3}} &
\multicolumn{{1}}{{c}}{{D4}} &
\multicolumn{{1}}{{c}}{{D5}} \\
\midrule
\endfirsthead

\toprule
Program &
\multicolumn{{1}}{{c}}{{D1}} &
\multicolumn{{1}}{{c}}{{D2}} &
\multicolumn{{1}}{{c}}{{D3}} &
\multicolumn{{1}}{{c}}{{D4}} &
\multicolumn{{1}}{{c}}{{D5}} \\
\midrule
\endhead

\midrule
\multicolumn{{6}}{{r}}{{Continued on next page}} \\
\endfoot

\bottomrule
\caption{{Measured mean energy per program and device. The summary rows show the minimum, median, and maximum measured mean energy over all programs for each device. Values in Joule.}}
\endlastfoot

{table_rows}

\end{{longtable}}
"""

    def add_summary_rows(self, measurement_dataframe: pd.DataFrame) -> pd.DataFrame:
        numeric_columns = ["D1", "D2", "D3", "D4", "D5"]

        minimum_row = {"Program": "Min"}
        median_row = {"Program": "Median"}
        maximum_row = {"Program": "Max"}

        for column_name in numeric_columns:
            minimum_row[column_name] = measurement_dataframe[column_name].min()
            median_row[column_name] = measurement_dataframe[column_name].median()
            maximum_row[column_name] = measurement_dataframe[column_name].max()

        return pd.concat(
            [
                measurement_dataframe,
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

    def create_measurement_dataframe(self) -> pd.DataFrame:
        measurement_rows = []

        for program_index, program_name in enumerate(program_names):
            measurement_row = {
                "Program": program_name,
            }

            for device_index in range(1, 6):
                statistics_path = Path(
                    f"../../data/device0{device_index}/measurements/raw/{program_index}/statistics.csv"
                )

                if not statistics_path.exists():
                    measurement_row[f"D{device_index}"] = None
                    continue

                statistics_dataframe = pd.read_csv(statistics_path)

                mean_row = statistics_dataframe[
                    statistics_dataframe["# Value"] == "mean"
                ]

                if mean_row.empty:
                    measurement_row[f"D{device_index}"] = None
                else:
                    measurement_row[f"D{device_index}"] = mean_row.iloc[0]["Energy"]

            measurement_rows.append(measurement_row)

        measurement_dataframe = pd.DataFrame(measurement_rows)

        measurement_dataframe = measurement_dataframe[
            ["Program", "D1", "D2", "D3", "D4", "D5"]
        ]

        return self.add_summary_rows(measurement_dataframe)

    def generate(self):
        measurement_dataframe = self.create_measurement_dataframe()

        output_csv_path = self.result_directory / "measured_energy_per_device.csv"
        measurement_dataframe.to_csv(output_csv_path, index=False)

        latex_table = self.create_table(measurement_dataframe)

        output_tex_path = self.result_directory / "measured_energy_per_device.tex"

        with open(output_tex_path, "w", encoding="utf-8") as file:
            file.write(latex_table)

        print(f"Saved CSV to {output_csv_path}")
        print(f"Saved LaTeX table to {output_tex_path}")
        