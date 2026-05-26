from pathlib import Path

from tables.util.Instructions import get_selected_instructions
from tables.util.Utility import format_decimal, get_result_dir

import pandas as pd


class CoVTable:
    selected_instructions = get_selected_instructions()
    result_directory = get_result_dir()

    def create_latex_row(self, row: pd.Series) -> str:
        values = [str(row["Instruction"])]

        for column_name in row.index[1:]:
            values.append(format_decimal(row[column_name]))

        return " & ".join(values) + r" \\"

    def generate_dataframe(self):
        device_dataframes = {}

        for device_index in range(1, 6):
            csv_path = Path(f"../../data/device0{device_index}/profile/cpu_stats.csv")
            device_dataframe = pd.read_csv(csv_path)

            device_dataframes[f"device0{device_index}"] = (
                device_dataframe[["instruction", "coefficient_of_variation"]]
                .rename(columns={"coefficient_of_variation": f"D{device_index}"})
            )

        merged_dataframe = None

        for device_dataframe in device_dataframes.values():
            if merged_dataframe is None:
                merged_dataframe = device_dataframe
            else:
                merged_dataframe = merged_dataframe.merge(
                    device_dataframe,
                    on="instruction",
                    how="outer",
                )

        merged_dataframe = merged_dataframe[
            ~merged_dataframe["instruction"].str.startswith("_")
        ]

        merged_dataframe = merged_dataframe[
            merged_dataframe["instruction"].isin(self.selected_instructions)
        ]

        merged_dataframe["instruction"] = pd.Categorical(
            merged_dataframe["instruction"],
            categories=self.selected_instructions,
            ordered=True,
        )

        merged_dataframe = merged_dataframe.sort_values("instruction").reset_index(drop=True)

        return merged_dataframe

    def generate_table(self, dataframe):
        dataframe.columns = [
            "Instruction",
            "D1",
            "D2",
            "D3",
            "D4",
            "D5",
        ]

        column_format = (
            "@{}l"
            + " S[table-format=1.2]" * 5
            + "@{}"
        )

        table_rows = "\n".join(
            self.create_latex_row(row)
            for _, row in dataframe.iterrows()
        )

        latex_table = rf"""\begin{{longtable}}{{{column_format}}}
        \label{{tab:instruction_cof}} \\

        \toprule
        Instruction &
        \multicolumn{{1}}{{c}}{{D1}} &
        \multicolumn{{1}}{{c}}{{D2}} &
        \multicolumn{{1}}{{c}}{{D3}} &
        \multicolumn{{1}}{{c}}{{D4}} &
        \multicolumn{{1}}{{c}}{{D5}} \\
        \midrule
        \endfirsthead

        \toprule
        Instruction &
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
        \caption{{Coefficient of variation per instruction and device}}
        \endlastfoot

        {table_rows}

        \end{{longtable}}
        """

        return (latex_table)


    def generate(self):
        output_csv_path = self.result_directory / "instruction_cof_per_device.csv"
        merged_dataframe = self.generate_dataframe()
        merged_dataframe.to_csv(output_csv_path, index=False)

        output_tex_path = self.result_directory / "instruction_cof.tex"

        (latex_table) = self.generate_table(merged_dataframe)

        with open(output_tex_path, "w", encoding="utf-8") as file:
            file.write(latex_table)

        print(f"Saved CSV to {output_csv_path}")
        print(f"Saved LaTeX table to {output_tex_path}")




