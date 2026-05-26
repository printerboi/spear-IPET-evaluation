from pathlib import Path

import pandas as pd

# Create output directory if it does not exist
results_directory = Path("results")
results_directory.mkdir(parents=True, exist_ok=True)

selected_instructions = [
    "add", "alloca", "and", "br", "call",
    "fadd", "fdiv", "fsub", "icmp eq", "load",
    "mul", "or", "sdiv", "select", "sext",
    "shl", "srem", "store", "sub", "udiv",
]

device_dataframes = {}

for device_index in range(1, 6):
    csv_path = Path(f"../../data/device0{device_index}/profile/cpu_stats.csv")
    device_dataframe = pd.read_csv(csv_path)

    device_dataframes[f"device0{device_index}"] = (
        device_dataframe[["instruction", "median_value"]]
        .rename(columns={"median_value": f"D{device_index}"})
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
    merged_dataframe["instruction"].isin(selected_instructions)
]

merged_dataframe["instruction"] = pd.Categorical(
    merged_dataframe["instruction"],
    categories=selected_instructions,
    ordered=True,
)

merged_dataframe = merged_dataframe.sort_values("instruction").reset_index(drop=True)

# Save CSV after filtering
output_csv_path = results_directory / "instruction_medians_per_device.csv"
merged_dataframe.to_csv(output_csv_path, index=False)


def format_scientific(value: float) -> str:
    return f"{value:.3e}"


def create_latex_row(row: pd.Series) -> str:
    values = [str(row["Instruction"])]

    for column_name in row.index[1:]:
        values.append(format_scientific(row[column_name]))

    return " & ".join(values) + r" \\"


merged_dataframe.columns = [
    "Instruction",
    "D1",
    "D2",
    "D3",
    "D4",
    "D5",
]

column_format = "@{}l" + " S[table-format=1.3e-2]" * 5 + "@{}"

table_rows = "\n".join(
    create_latex_row(row)
    for _, row in merged_dataframe.iterrows()
)

latex_table = rf"""\begin{{longtable}}{{{column_format}}}
\label{{tab:instruction_medians}} \\

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
\caption{{Median energy values per instruction and device}}
\endlastfoot

{table_rows}

\end{{longtable}}
"""

output_tex_path = results_directory / "instruction_medians.tex"

with open(output_tex_path, "w", encoding="utf-8") as file:
    file.write(latex_table)

print(f"Saved CSV to {output_csv_path}")
print(f"Saved LaTeX table to {output_tex_path}")