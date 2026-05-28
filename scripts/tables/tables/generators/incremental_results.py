from pathlib import Path

import pandas as pd

from tables.util.Utility import (
    format_decimal,
    format_milliseconds,
    get_result_dir,
)


class IncrementalRuntimeTable:
    incremental_directory = Path("../../data/device01/incremental")
    result_directory = get_result_dir()

    scenario_order = [
        ("baseline", "Baseline", "None", "No"),
        ("v1", "V1", "Outside validation loop", "No"),
        ("v2", "V2", "Validation loop body", "Yes"),
        ("v3", "V3", "Validation loop structure", "Yes"),
    ]

    def create_latex_row(self, row: pd.Series) -> str:
        values = [
            str(row["Scenario"]),
            str(row["Changed region"]),
            str(row["Loop modified"]),
            format_milliseconds(row["Monolithic"]),
            format_milliseconds(row["Cached"]),
            format_decimal(row["Speedup"]),
        ]

        return " & ".join(values) + r" \\"

    def create_table(self, dataframe: pd.DataFrame) -> str:
        column_format = (
            "@{}l"
            "l"
            "l"
            "S[table-format=4.3]"
            "S[table-format=4.3]"
            "S[table-format=2.2]"
            "@{}"
        )

        table_rows = "\n".join(dataframe.apply(self.create_latex_row, axis=1))

        return rf"""\begin{{longtable}}{{{column_format}}}
        \label{{tab:incremental_runtime}} \\

        \toprule
        Scenario &
        Changed region &
        Loop modified &
        \multicolumn{{1}}{{c}}{{Monolithic}} &
        \multicolumn{{1}}{{c}}{{Cached}} &
        \multicolumn{{1}}{{c}}{{Speedup}} \\
        \midrule
        \endfirsthead

        \toprule
        Scenario &
        Changed region &
        Loop modified &
        \multicolumn{{1}}{{c}}{{Monolithic}} &
        \multicolumn{{1}}{{c}}{{Cached}} &
        \multicolumn{{1}}{{c}}{{Speedup}} \\
        \midrule
        \endhead

        \midrule
        \multicolumn{{6}}{{r}}{{Continued on next page}} \\
        \endfoot

        \bottomrule
        \caption{{Incremental reanalysis runtime for the \texttt{{keyExchange}} program after localized changes. Runtime values are given in milliseconds.}}
        \endlastfoot

        {table_rows}

        \end{{longtable}}
        """

    def get_main_duration_by_file_suffix(
        self,
        summary_dataframe: pd.DataFrame,
        file_suffix: str,
    ):
        matching_rows = summary_dataframe[
            summary_dataframe["file"].str.endswith(file_suffix, na=False)
        ]

        if matching_rows.empty:
            return None

        return matching_rows.iloc[0]["duration"]

    def generate(self):
        runtime_rows = []

        for program_name, scenario_name, changed_region, loop_modified in self.scenario_order:
            summary_csv_path = self.incremental_directory / f"{program_name}_analysis_summary.csv"

            if not summary_csv_path.exists():
                raise FileNotFoundError(f"Missing summary file: {summary_csv_path}")

            summary_dataframe = pd.read_csv(summary_csv_path)

            monolithic_runtime = self.get_main_duration_by_file_suffix(
                summary_dataframe,
                "_monolithic.json",
            )

            cached_runtime = self.get_main_duration_by_file_suffix(
                summary_dataframe,
                "_cache.json",
            )

            speedup = (
                monolithic_runtime / cached_runtime
                if cached_runtime is not None and cached_runtime > 0
                else None
            )

            runtime_rows.append({
                "Scenario": scenario_name,
                "Changed region": changed_region,
                "Loop modified": loop_modified,
                "Monolithic": monolithic_runtime,
                "Cached": cached_runtime,
                "Speedup": speedup,
            })

        runtime_dataframe = pd.DataFrame(runtime_rows)

        output_csv_path = self.result_directory / "incremental_runtime.csv"
        runtime_dataframe.to_csv(output_csv_path, index=False)

        latex_table = self.create_table(runtime_dataframe)

        output_tex_path = self.result_directory / "incremental_runtime.tex"

        with open(output_tex_path, "w", encoding="utf-8") as file:
            file.write(latex_table)

        print(f"Saved CSV to {output_csv_path}")
        print(f"Saved LaTeX table to {output_tex_path}")