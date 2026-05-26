from pathlib import Path

import pandas as pd

# Create output directory if it does not exist
results_directory = Path("results")
results_directory.mkdir(parents=True, exist_ok=True)

analysis_directory = Path("../../data/device02/analysis")

analysis_rows = []

analysis_order = [
    ("legacy", "Legacy"),
    ("clustered", "Clustered"),
    ("monolithic", "Monolithic"),
]

for csv_path in sorted(analysis_directory.glob("*_summary.csv")):
    summary_dataframe = pd.read_csv(csv_path)

    program_name = csv_path.stem.removesuffix("_summary").removesuffix("_analysis")

    duration_values = {
        "Program": program_name,
    }

    for analysis_name, column_name in analysis_order:
        matching_rows = summary_dataframe[
            summary_dataframe["analysis"] == analysis_name
        ]

        if matching_rows.empty:
            duration_values[column_name] = None
        else:
            duration_values[column_name] = (
                matching_rows.iloc[0]["duration"] / 1000.0
            )

    cached_rows = summary_dataframe[
        summary_dataframe["file"].str.endswith("_cache.json", na=False)
    ]

    if cached_rows.empty:
        duration_values["Clustered cached"] = None
    else:
        duration_values["Clustered cached"] = (
            cached_rows.iloc[0]["duration"] / 1000.0
        )

    analysis_rows.append(duration_values)

duration_dataframe = pd.DataFrame(analysis_rows)

duration_dataframe = duration_dataframe[
    ["Program", "Legacy", "Clustered", "Monolithic", "Clustered cached"]
]

output_csv_path = results_directory / "device02_program_duration_ms.csv"
duration_dataframe.to_csv(output_csv_path, index=False)


def format_milliseconds(value: float) -> str:
    if pd.isna(value):
        return "--"

    return f"{value:.3f}"


def escape_latex(text: str) -> str:
    return text.replace("_", r"\_")


def format_program_name(program_name: str) -> str:
    return rf"\texttt{{{escape_latex(program_name)}}}"


def create_latex_row(row: pd.Series) -> str:
    values = [
        format_program_name(str(row["Program"])),
        format_milliseconds(row["Legacy"]),
        format_milliseconds(row["Clustered"]),
        format_milliseconds(row["Monolithic"]),
        format_milliseconds(row["Clustered cached"]),
    ]

    return " & ".join(values) + r" \\"


column_format = (
    "@{}l"
    "S[table-format=4.3]"
    "S[table-format=4.3]"
    "S[table-format=4.3]"
    "S[table-format=4.3]"
    "@{}"
)

table_rows = "\n".join(
    create_latex_row(row)
    for _, row in duration_dataframe.iterrows()
)

latex_table = rf"""\begin{{longtable}}{{{column_format}}}
\label{{tab:device02_program_duration}} \\

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
\caption{{Analysis duration per program for device D2}}
\endlastfoot

{table_rows}

\end{{longtable}}
"""

output_tex_path = results_directory / "device02_program_duration_ms.tex"

with open(output_tex_path, "w", encoding="utf-8") as file:
    file.write(latex_table)

print(f"Saved CSV to {output_csv_path}")
print(f"Saved LaTeX table to {output_tex_path}")