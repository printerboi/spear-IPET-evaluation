from pathlib import Path

import pandas as pd

from tables.util.Utility import format_scientific, get_result_dir


class SyscallEnergyTable:
    selected_syscalls = [
        "accept",
        "bind",
        "clone",
        "execve",
        "fsync",
        "futex",
        "lseek",
        "openat",
        "read",
        "write"
    ]

    result_directory = get_result_dir()

    def create_latex_row(self, row: pd.Series) -> str:
        values = [str(row["Syscall"])]

        for column_name in row.index[1:]:
            values.append(format_scientific(row[column_name]))

        return " & ".join(values) + r" \\"

    def generate_dataframe(self):
        device_dataframes = {}

        for device_index in range(1, 6):
            csv_path = Path(f"../../data/device0{device_index}/profile/syscall_stats.csv")
            device_dataframe = pd.read_csv(csv_path)

            device_dataframes[f"device0{device_index}"] = (
                device_dataframe[["syscall", "median_value"]]
                .rename(columns={"median_value": f"D{device_index}"})
            )

        merged_dataframe = None

        for device_dataframe in device_dataframes.values():
            if merged_dataframe is None:
                merged_dataframe = device_dataframe
            else:
                merged_dataframe = merged_dataframe.merge(
                    device_dataframe,
                    on="syscall",
                    how="outer",
                )

        merged_dataframe = merged_dataframe[
            merged_dataframe["syscall"].isin(self.selected_syscalls)
        ]

        merged_dataframe["syscall"] = pd.Categorical(
            merged_dataframe["syscall"],
            categories=self.selected_syscalls,
            ordered=True,
        )

        merged_dataframe = merged_dataframe.sort_values("syscall").reset_index(drop=True)

        minimum_row = {
            "syscall": "Min",
        }

        maximum_row = {
            "syscall": "Max",
        }

        for device_index in range(1, 6):
            column_name = f"D{device_index}"

            minimum_row[column_name] = merged_dataframe[column_name].min()
            maximum_row[column_name] = merged_dataframe[column_name].max()

        merged_dataframe = pd.concat(
            [
                merged_dataframe,
                pd.DataFrame([minimum_row, maximum_row]),
            ],
            ignore_index=True,
        )

        return merged_dataframe

    def generate_table(self, dataframe):
        dataframe.columns = [
            "Syscall",
            "D1",
            "D2",
            "D3",
            "D4",
            "D5",
        ]

        column_format = (
            "@{}l"
            + " S[table-format=1.3e-2]" * 5
            + "@{}"
        )

        latex_rows = []

        for _, row in dataframe.iterrows():
            if row["Syscall"] == "Min":
                latex_rows.append(r"\midrule")

            latex_rows.append(self.create_latex_row(row))

        table_rows = "\n".join(latex_rows)

        latex_table = rf"""\begin{{longtable}}{{{column_format}}}
        \label{{tab:syscall_medians}} \\

        \toprule
        Syscall &
        \multicolumn{{1}}{{c}}{{D1}} &
        \multicolumn{{1}}{{c}}{{D2}} &
        \multicolumn{{1}}{{c}}{{D3}} &
        \multicolumn{{1}}{{c}}{{D4}} &
        \multicolumn{{1}}{{c}}{{D5}} \\
        \midrule
        \endfirsthead

        \toprule
        Syscall &
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
        \caption{{Mean energy values per syscall and device. The last two
        rows show the minimum and maximum value over the selected syscall set for the respective device. Values in Joule.}}
        \endlastfoot

        {table_rows}

        \end{{longtable}}
        """

        return latex_table

    def generate(self):
        output_csv_path = self.result_directory / "syscall_medians_per_device.csv"
        merged_dataframe = self.generate_dataframe()
        merged_dataframe.to_csv(output_csv_path, index=False)

        output_tex_path = self.result_directory / "syscall_medians.tex"

        latex_table = self.generate_table(merged_dataframe)

        with open(output_tex_path, "w", encoding="utf-8") as file:
            file.write(latex_table)

        print(f"Saved CSV to {output_csv_path}")
        print(f"Saved LaTeX table to {output_tex_path}")