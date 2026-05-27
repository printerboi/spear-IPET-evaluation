from pathlib import Path

import pandas as pd

from tables.util.Utility import format_milliseconds, format_program_name, get_result_dir


device_id = 2


class AnalysisRuntimeTable:
    analysis_directory = Path(f"../../data/device0{device_id}/analysis")
    result_directory = get_result_dir()

    analysis_order = [
        ("legacy", "Legacy"),
        ("monolithic", "Monolithic"),
        ("clustered", "Clustered"),
    ]

    def create_latex_row(self, row: pd.Series) -> str:
        values = [
            format_program_name(str(row["Program"])),
            format_milliseconds(row["Legacy"]),
            format_milliseconds(row["Monolithic"]),
            format_milliseconds(row["Clustered"]),
            format_milliseconds(row["Clustered cached"]),
        ]

        return " & ".join(values) + r" \\"

    def create_table(self, duration_dataframe: pd.DataFrame) -> str:
        column_format = (
            "@{}l"
            "S[table-format=4.3]"
            "S[table-format=4.3]"
            "S[table-format=4.3]"
            "S[table-format=4.3]"
            "@{}"
        )

        latex_rows = []

        for _, row in duration_dataframe.iterrows():
            if row["Program"] == "Min":
                latex_rows.append(r"\midrule")

            latex_rows.append(self.create_latex_row(row))

        table_rows = "\n".join(latex_rows)

        return rf"""\begin{{longtable}}{{{column_format}}}
\label{{tab:device0{device_id}_program_duration}} \\

\toprule
Program &
\multicolumn{{1}}{{c}}{{Legacy}} &
\multicolumn{{1}}{{c}}{{Monolithic}} &
\multicolumn{{1}}{{c}}{{Clustered}} &
\multicolumn{{1}}{{c}}{{Cached}} \\
\midrule
\endfirsthead

\toprule
Program &
\multicolumn{{1}}{{c}}{{Legacy}} &
\multicolumn{{1}}{{c}}{{Monolithic}} &
\multicolumn{{1}}{{c}}{{Clustered}} &
\multicolumn{{1}}{{c}}{{Cached}} \\
\midrule
\endhead

\midrule
\multicolumn{{5}}{{r}}{{Continued on next page}} \\
\endfoot

\bottomrule
\caption{{Mean analysis duration per program for device D{device_id}. The summary rows show the minimum, median, and maximum duration over all programs for the respective method. All values in milliseconds.}}
\endlastfoot

{table_rows}

\end{{longtable}}
"""

    def create_duration_dataframe(self) -> pd.DataFrame:
        analysis_rows = []

        for csv_path in sorted(self.analysis_directory.glob("*_summary.csv")):
            summary_dataframe = pd.read_csv(csv_path)

            program_name = (
                csv_path.stem
                .removesuffix("_summary")
                .removesuffix("_analysis")
            )

            duration_values = {
                "Program": program_name,
            }

            for analysis_name, column_name in self.analysis_order:
                matching_rows = summary_dataframe[
                    summary_dataframe["analysis"] == analysis_name
                ]

                if matching_rows.empty:
                    duration_values[column_name] = None
                else:
                    duration_values[column_name] = matching_rows.iloc[0]["duration"] / 1000.0

            cached_rows = summary_dataframe[
                summary_dataframe["file"].str.endswith("_cache.json", na=False)
            ]

            if cached_rows.empty:
                duration_values["Clustered cached"] = None
            else:
                duration_values["Clustered cached"] = cached_rows.iloc[0]["duration"] / 1000.0

            analysis_rows.append(duration_values)

        duration_dataframe = pd.DataFrame(analysis_rows)

        duration_dataframe = duration_dataframe[
            ~duration_dataframe["Program"].str.startswith("benchmark")
        ]

        return duration_dataframe[
            ["Program", "Legacy", "Monolithic", "Clustered", "Clustered cached"]
        ]

    def add_summary_rows(self, duration_dataframe: pd.DataFrame) -> pd.DataFrame:
        numeric_columns = [
            "Legacy",
            "Monolithic",
            "Clustered",
            "Clustered cached",
        ]

        minimum_row = {"Program": "Min"}
        median_row = {"Program": "Median"}
        maximum_row = {"Program": "Max"}

        for column_name in numeric_columns:
            minimum_row[column_name] = duration_dataframe[column_name].min()
            median_row[column_name] = duration_dataframe[column_name].median()
            maximum_row[column_name] = duration_dataframe[column_name].max()

        return pd.concat(
            [
                duration_dataframe,
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

    def generate(self):
        duration_dataframe = self.create_duration_dataframe()
        duration_dataframe = self.add_summary_rows(duration_dataframe)

        output_csv_path = self.result_directory / f"device0{device_id}_program_duration_ms.csv"
        duration_dataframe.to_csv(output_csv_path, index=False)

        latex_table = self.create_table(duration_dataframe)

        output_tex_path = self.result_directory / f"device0{device_id}_program_duration_ms.tex"

        with open(output_tex_path, "w", encoding="utf-8") as file:
            file.write(latex_table)

        print(f"Saved CSV to {output_csv_path}")
        print(f"Saved LaTeX table to {output_tex_path}")
