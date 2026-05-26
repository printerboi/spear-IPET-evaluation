from pathlib import Path

from tables.util.Utility import get_result_dir, format_decimal, format_scientific

import pandas as pd

device_id = 4

class SingularDeviceAllValuesTable:
    csv_path = Path(f"../../data/device0{device_id}/profile/cpu_stats.csv")
    result_directory = get_result_dir()

    def create_statistics_latex_row(self, row: pd.Series) -> str:
        values = [
            str(row["Instruction"]),
            format_scientific(row["Median"]),
            format_scientific(row["Mean"]),
            format_scientific(row["Std"]),
            format_scientific(row["Var"]),
            format_decimal(row["CoV"]),
        ]

        return " & ".join(values) + r" \\"


    def create_range_latex_row(self, row: pd.Series) -> str:
        values = [
            str(row["Instruction"]),
            format_scientific(row["Min"]),
            format_scientific(row["Max"]),
        ]

        return " & ".join(values) + r" \\"


    def create_table(self, dataframe):
    

        statistics_column_format = (
            "@{}l"
            "S[table-format=1.3e-2]"
            "S[table-format=1.3e-2]"
            "S[table-format=1.3e-2]"
            "S[table-format=1.3e-3]"
            "S[table-format=1.2]"
            "@{}"
        )

        range_column_format = (
            "@{}l"
            "S[table-format=1.3e-2]"
            "S[table-format=1.3e-2]"
            "@{}"
        )

        statistics_table_rows = "\n".join(
            self.create_statistics_latex_row(row)
            for _, row in dataframe.iterrows()
        )

        range_table_rows = "\n".join(
            self.create_range_latex_row(row)
            for _, row in dataframe.iterrows()
        )

        statistics_latex_table = rf"""\begin{{longtable}}{{{statistics_column_format}}}
    \label{{tab:device0{device_id}_instruction_profile_statistics}} \\

    \toprule
    Instruction &
    \multicolumn{{1}}{{c}}{{Median}} &
    \multicolumn{{1}}{{c}}{{Mean}} &
    \multicolumn{{1}}{{c}}{{Std}} &
    \multicolumn{{1}}{{c}}{{Var}} &
    \multicolumn{{1}}{{c}}{{CoV}} \\
    \midrule
    \endfirsthead

    \toprule
    Instruction &
    \multicolumn{{1}}{{c}}{{Median}} &
    \multicolumn{{1}}{{c}}{{Mean}} &
    \multicolumn{{1}}{{c}}{{Std}} &
    \multicolumn{{1}}{{c}}{{Var}} &
    \multicolumn{{1}}{{c}}{{CoV}} \\
    \midrule
    \endhead

    \midrule
    \multicolumn{{6}}{{r}}{{Continued on next page}} \\
    \endfoot

    \bottomrule
    \caption{{Instruction profile statistics for device D4}}
    \endlastfoot

    {statistics_table_rows}

    \end{{longtable}}
        """

        range_latex_table = rf"""\begin{{longtable}}{{{range_column_format}}}
    \label{{tab:device0{device_id}_instruction_profile_range}} \\

    \toprule
    Instruction &
    \multicolumn{{1}}{{c}}{{Min}} &
    \multicolumn{{1}}{{c}}{{Max}} \\
    \midrule
    \endfirsthead

    \toprule
    Instruction &
    \multicolumn{{1}}{{c}}{{Min}} &
    \multicolumn{{1}}{{c}}{{Max}} \\
    \midrule
    \endhead

    \midrule
    \multicolumn{{3}}{{r}}{{Continued on next page}} \\
    \endfoot

    \bottomrule
    \caption{{Instruction profile minimum and maximum values for device D4}}
    \endlastfoot

    {range_table_rows}

    \end{{longtable}}
        """

        return (statistics_latex_table, range_latex_table)

    def generate(self):
        instruction_dataframe = (
            pd.read_csv(self.csv_path)
            .query("instruction not in ['_noise', '_unknown_cost']")
            .replace({"instruction": {"_programoffset": "programoffset"}})
        )

        instruction_dataframe = instruction_dataframe.rename(columns={
            "instruction": "Instruction",
            "median_value": "Median",
            "mean_value": "Mean",
            "std_value": "Std",
            "var_value": "Var",
            "min_value": "Min",
            "max_value": "Max",
            "coefficient_of_variation": "CoV",
        })



        output_csv_path = get_result_dir() / f"device0{device_id}_instruction_profile.csv"
        instruction_dataframe.to_csv(output_csv_path, index=False)
        
        (statistics_latex_table, range_latex_table) = self.create_table(instruction_dataframe)

        statistics_output_tex_path = self.result_directory / f"device0{device_id}_instruction_profile_statistics.tex"
        range_output_tex_path = self.result_directory / f"device0{device_id}_instruction_profile_range.tex"

        with open(statistics_output_tex_path, "w", encoding="utf-8") as file:
            file.write(statistics_latex_table)

        with open(range_output_tex_path, "w", encoding="utf-8") as file:
            file.write(range_latex_table)

        print(f"Saved CSV to {output_csv_path}")
        print(f"Saved statistics LaTeX table to {statistics_output_tex_path}")
        print(f"Saved range LaTeX table to {range_output_tex_path}")