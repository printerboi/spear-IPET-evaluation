from pathlib import Path

import pandas as pd

from tables.util.Utility import format_decimal, format_scientific, get_result_dir


class ProgramOffsetPerDeviceTable:
    result_directory = get_result_dir()

    def create_latex_row(self, row: pd.Series) -> str:
        values = [
            str(row["Device"]),
            str(row["Instruction"]),
            format_scientific(row["Median"]),
            format_scientific(row["Std"]),
            format_decimal(row["CoV"]),
        ]

        return " & ".join(values) + r" \\"

    def generate_dataframe(self):
        offset_rows = []

        for device_index in range(1, 6):
            csv_path = Path(f"../../data/device0{device_index}/profile/cpu_stats.csv")
            device_dataframe = pd.read_csv(csv_path)

            offset_row = device_dataframe[
                device_dataframe["instruction"] == "_programoffset"
            ].iloc[0]

            offset_rows.append({
                "Device": f"D{device_index}",
                "Instruction": "programoffset",
                "Median": offset_row["median_value"],
                "Std": offset_row["std_value"],
                "CoV": offset_row["coefficient_of_variation"],
            })

        return pd.DataFrame(offset_rows)

    def generate_table(self, offset_dataframe):
        column_format = (
            "@{}ll"
            "S[table-format=1.3e-2]"
            "S[table-format=1.3e-2]"
            "S[table-format=1.2]"
            "@{}"
        )

        table_rows = "\n".join(
            self.create_latex_row(row)
            for _, row in offset_dataframe.iterrows()
        )

        latex_table = rf"""\begin{{longtable}}{{{column_format}}}
\label{{tab:programoffset_per_device}} \\

\toprule
Device &
Instruction &
\multicolumn{{1}}{{c}}{{Median}} &
\multicolumn{{1}}{{c}}{{Std}} &
\multicolumn{{1}}{{c}}{{CoV}} \\
\midrule
\endfirsthead

\toprule
Device &
Instruction &
\multicolumn{{1}}{{c}}{{Median}} &
\multicolumn{{1}}{{c}}{{Std}} &
\multicolumn{{1}}{{c}}{{CoV}} \\
\midrule
\endhead

\midrule
\multicolumn{{5}}{{r}}{{Continued on next page}} \\
\endfoot

\bottomrule
\caption{{Program offset statistics per device}}
\endlastfoot

{table_rows}

\end{{longtable}}
"""

        return latex_table

    def generate(self):
        output_csv_path = self.result_directory / "programoffset_per_device.csv"
        offset_dataframe = self.generate_dataframe()
        offset_dataframe.to_csv(output_csv_path, index=False)

        output_tex_path = self.result_directory / "programoffset_per_device.tex"

        latex_table = self.generate_table(offset_dataframe)

        with open(output_tex_path, "w", encoding="utf-8") as file:
            file.write(latex_table)

        print(f"Saved CSV to {output_csv_path}")
        print(f"Saved LaTeX table to {output_tex_path}")