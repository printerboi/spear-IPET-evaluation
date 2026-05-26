from pathlib import Path

import pandas as pd

# Create output directory if it does not exist
results_directory = Path("results")
results_directory.mkdir(parents=True, exist_ok=True)

csv_path = Path("../../data/device04/profile/cpu_stats.csv")

instruction_dataframe = (
    pd.read_csv(csv_path)
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

output_csv_path = results_directory / "device04_instruction_profile.csv"
instruction_dataframe.to_csv(output_csv_path, index=False)


def format_scientific(value: float) -> str:
    return f"{value:.3e}"


def format_decimal(value: float) -> str:
    return f"{value:.2f}"


def create_statistics_latex_row(row: pd.Series) -> str:
    values = [
        str(row["Instruction"]),
        format_scientific(row["Median"]),
        format_scientific(row["Mean"]),
        format_scientific(row["Std"]),
        format_scientific(row["Var"]),
        format_decimal(row["CoV"]),
    ]

    return " & ".join(values) + r" \\"


def create_range_latex_row(row: pd.Series) -> str:
    values = [
        str(row["Instruction"]),
        format_scientific(row["Min"]),
        format_scientific(row["Max"]),
    ]

    return " & ".join(values) + r" \\"


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
    create_statistics_latex_row(row)
    for _, row in instruction_dataframe.iterrows()
)

range_table_rows = "\n".join(
    create_range_latex_row(row)
    for _, row in instruction_dataframe.iterrows()
)

statistics_latex_table = rf"""\begin{{longtable}}{{{statistics_column_format}}}
\label{{tab:device04_instruction_profile_statistics}} \\

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
\label{{tab:device04_instruction_profile_range}} \\

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

statistics_output_tex_path = results_directory / "device04_instruction_profile_statistics.tex"
range_output_tex_path = results_directory / "device04_instruction_profile_range.tex"

with open(statistics_output_tex_path, "w", encoding="utf-8") as file:
    file.write(statistics_latex_table)

with open(range_output_tex_path, "w", encoding="utf-8") as file:
    file.write(range_latex_table)

print(f"Saved CSV to {output_csv_path}")
print(f"Saved statistics LaTeX table to {statistics_output_tex_path}")
print(f"Saved range LaTeX table to {range_output_tex_path}")