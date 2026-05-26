from pathlib import Path

import pandas as pd

from tables.util.Utility import get_result_dir, format_milliseconds, format_program_name


device_id = 2


class AnalysisRuntimeTable:
    analysis_directory = Path(f"../../data/device0{device_id}/analysis")
    result_directory = get_result_dir()

    analysis_order = [
        ("legacy", "Legacy"),
        ("clustered", "Clustered"),
        ("monolithic", "Monolithic"),
    ]

    def create_latex_row(self, row: pd.Series) -> str:
        values = [
            format_program_name(str(row["Program"])),
            format_milliseconds(row["Legacy"]),
            format_milliseconds(row["Clustered"]),
            format_milliseconds(row["Monolithic"]),
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

        table_rows = "\n".join(
            self.create_latex_row(row)
            for _, row in duration_dataframe.iterrows()
        )

        return rf"""\begin{{longtable}}{{{column_format}}}
\label{{tab:device0{device_id}_program_duration}} \\

\toprule
Program &
\multicolumn{{1}}{{c}}{{Legacy (ms)}} &
\multicolumn{{1}}{{c}}{{Clustered (ms)}} &
\multicolumn{{1}}{{c}}{{Monolithic (ms)}} &
\multicolumn{{1}}{{c}}{{Clustered cached (ms)}} \\
\midrule
\endfirsthead

\toprule
Program &
\multicolumn{{1}}{{c}}{{Legacy (ms)}} &
\multicolumn{{1}}{{c}}{{Clustered (ms)}} &
\multicolumn{{1}}{{c}}{{Monolithic (ms)}} &
\multicolumn{{1}}{{c}}{{Clustered cached (ms)}} \\
\midrule
\endhead

\midrule
\multicolumn{{5}}{{r}}{{Continued on next page}} \\
\endfoot

\bottomrule
\caption{{Analysis duration per program for device D{device_id}}}
\endlastfoot

{table_rows}

\end{{longtable}}
"""

    def create_duration_dataframe(self) -> pd.DataFrame:
        analysis_rows = []

        for csv_path in sorted(self.analysis_directory.glob("*_summary.csv")):
            summary_dataframe = pd.read_csv(csv_path)

            program_name = csv_path.stem.removesuffix("_summary").removesuffix("_analysis")

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

        return duration_dataframe[
            ["Program", "Legacy", "Clustered", "Monolithic", "Clustered cached"]
        ]

    def generate(self):
        duration_dataframe = self.create_duration_dataframe()

        output_csv_path = self.result_directory / f"device0{device_id}_program_duration_ms.csv"
        duration_dataframe.to_csv(output_csv_path, index=False)

        latex_table = self.create_table(duration_dataframe)

        output_tex_path = self.result_directory / f"device0{device_id}_program_duration_ms.tex"

        with open(output_tex_path, "w", encoding="utf-8") as file:
            file.write(latex_table)

        print(f"Saved CSV to {output_csv_path}")
        print(f"Saved LaTeX table to {output_tex_path}")