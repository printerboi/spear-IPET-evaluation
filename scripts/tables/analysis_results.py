from pathlib import Path

import pandas as pd

# Create output directory if it does not exist
results_directory = Path("results")
results_directory.mkdir(parents=True, exist_ok=True)

analysis_directory = Path("../../data/device01/analysis")

analysis_rows = []

analysis_order = ["legacy", "monolithic", "clustered"]

for csv_path in sorted(analysis_directory.glob("*_summary.csv")):
    summary_dataframe = pd.read_csv(csv_path)

    program_name = csv_path.stem.removesuffix("_summary").removesuffix("_analysis")

    energy_values = {
        "Program": program_name,
    }

    for analysis_name in analysis_order:
        matching_rows = summary_dataframe[
            summary_dataframe["analysis"] == analysis_name
        ]

        if matching_rows.empty:
            energy_values[analysis_name.capitalize()] = None
        else:
            energy_values[analysis_name.capitalize()] = matching_rows.iloc[0]["main_energy"]

    analysis_rows.append(energy_values)

energy_dataframe = pd.DataFrame(analysis_rows)

energy_dataframe = energy_dataframe[
    ["Program", "Legacy", "Monolithic", "Clustered"]
]

output_csv_path = results_directory / "program_energy.csv"
energy_dataframe.to_csv(output_csv_path, index=False)


def format_scientific(value: float) -> str:
    if pd.isna(value):
        return "--"

    return f"{value:.3e}"


def escape_latex(text: str) -> str:
    return text.replace("_", r"\_")


def format_program_name(program_name: str) -> str:
    return rf"\texttt{{{escape_latex(program_name)}}}"


def create_latex_row(row: pd.Series) -> str:
    values = [
        format_program_name(str(row["Program"])),
        format_scientific(row["Legacy"]),
        format_scientific(row["Monolithic"]),
        format_scientific(row["Clustered"]),
    ]

    return " & ".join(values) + r" \\"


column_format = (
    "@{}l"
    "S[table-format=1.3e-2]"
    "S[table-format=1.3e-2]"
    "S[table-format=1.3e-2]"
    "@{}"
)

table_rows = "\n".join(
    create_latex_row(row)
    for _, row in energy_dataframe.iterrows()
)

latex_table = rf"""\begin{{longtable}}{{{column_format}}}
\label{{tab:program_energy}} \\

\toprule
Program &
\multicolumn{{1}}{{c}}{{Legacy}} &
\multicolumn{{1}}{{c}}{{Monolithic}} &
\multicolumn{{1}}{{c}}{{Clustered}} \\
\midrule
\endfirsthead

\toprule
Program &
\multicolumn{{1}}{{c}}{{Legacy}} &
\multicolumn{{1}}{{c}}{{Monolithic}} &
\multicolumn{{1}}{{c}}{{Clustered}} \\
\midrule
\endhead

\midrule
\multicolumn{{4}}{{r}}{{Continued on next page}} \\
\endfoot

\bottomrule
\caption{{Main energy values per benchmark}}
\endlastfoot

{table_rows}

\end{{longtable}}
"""

output_tex_path = results_directory / "program_energy.tex"

with open(output_tex_path, "w", encoding="utf-8") as file:
    file.write(latex_table)

print(f"Saved CSV to {output_csv_path}")
print(f"Saved LaTeX table to {output_tex_path}")