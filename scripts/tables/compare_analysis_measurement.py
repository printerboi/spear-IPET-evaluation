from pathlib import Path
import math

import pandas as pd

# Create output directory if it does not exist
results_directory = Path("results")
results_directory.mkdir(parents=True, exist_ok=True)

device_index = 5

program_names = [
    "asymmetricEncryption",
    "symmetricFileEncrypt",
    "pwhash",
    "signing",
    "chachaEncryption",
    "chachaDecryption",
    "keyExchange",
    "mac",
    "blockCompression",
    "blockDeCompression",
    "fileCompression",
    "ringbufferCompression",
    "dictionaryCompression",
    "aStarEmpty",
    "aStarMaze",
    "dijkstra",
    "bfs",
    "greedyBestFirst",
    "addMul",
    "moduloExp",
    "rsa",
    "primeTest",
    "gcd",
    "createJson",
    "parseJson",
    "searchJson",
    "malformedInput",
    "mergeJson",
    "wc",
    "cat",
    "sort",
    "uniq",
    "tail",
]


def read_measurement_energy(program_index: int) -> float | None:
    statistics_path = Path(
        f"../../data/device0{device_index}/measurements/raw/{program_index}/statistics.csv"
    )

    if not statistics_path.exists():
        return None

    statistics_dataframe = pd.read_csv(statistics_path)

    mean_row = statistics_dataframe[
        statistics_dataframe["# Value"] == "mean"
    ]

    if mean_row.empty:
        return None

    return mean_row.iloc[0]["Energy"]


def read_analysis_energy(program_name: str, analysis_name: str) -> float | None:
    summary_path = Path(
        f"../../data/device0{device_index}/analysis/{program_name}_summary.csv"
    )

    if not summary_path.exists():
        summary_path = Path(
            f"../../data/device0{device_index}/analysis/{program_name}_analysis_summary.csv"
        )

    if not summary_path.exists():
        return None

    summary_dataframe = pd.read_csv(summary_path)

    analysis_row = summary_dataframe[
        summary_dataframe["analysis"] == analysis_name
    ]

    if analysis_row.empty:
        return None

    return analysis_row.iloc[0]["main_energy"]


def calculate_magnitude_difference(
    measurement: float | None,
    analysis_value: float | None,
) -> float | None:
    if measurement is None or analysis_value is None:
        return None

    if measurement <= 0 or analysis_value <= 0:
        return None

    return math.log10(analysis_value / measurement)


comparison_rows = []

for program_index, program_name in enumerate(program_names):
    measurement = read_measurement_energy(program_index)
    legacy = read_analysis_energy(program_name, "legacy")
    clustered = read_analysis_energy(program_name, "clustered")

    comparison_rows.append({
        "Program": program_name,
        "Measurement": measurement,
        "Legacy": legacy,
        "Legacy Magnitude Difference": calculate_magnitude_difference(measurement, legacy),
        "Clustered": clustered,
        "Clustered Magnitude Difference": calculate_magnitude_difference(measurement, clustered),
    })

comparison_dataframe = pd.DataFrame(comparison_rows)

comparison_dataframe = comparison_dataframe[
    [
        "Program",
        "Measurement",
        "Legacy",
        "Legacy Magnitude Difference",
        "Clustered",
        "Clustered Magnitude Difference",
    ]
]

output_csv_path = results_directory / "device05_analysis_vs_measurement_magnitude_difference.csv"
comparison_dataframe.to_csv(output_csv_path, index=False)


def format_scientific(value: float) -> str:
    if pd.isna(value):
        return "--"

    return f"{value:.3e}"


def format_magnitude_difference(value: float) -> str:
    if pd.isna(value):
        return "--"

    return f"{value:.2f}"


def escape_latex(text: str) -> str:
    return text.replace("_", r"\_")


def format_program_name(program_name: str) -> str:
    return rf"\texttt{{{escape_latex(program_name)}}}"


def create_latex_row(row: pd.Series) -> str:
    values = [
        format_program_name(str(row["Program"])),
        format_scientific(row["Measurement"]),
        format_scientific(row["Legacy"]),
        format_magnitude_difference(row["Legacy Magnitude Difference"]),
        format_scientific(row["Clustered"]),
        format_magnitude_difference(row["Clustered Magnitude Difference"]),
    ]

    return " & ".join(values) + r" \\"


column_format = (
    "@{}l"
    "S[table-format=1.3e-2]"
    "S[table-format=1.3e-2]"
    "S[table-format=2.2]"
    "S[table-format=1.3e-2]"
    "S[table-format=2.2]"
    "@{}"
)

table_rows = "\n".join(
    create_latex_row(row)
    for _, row in comparison_dataframe.iterrows()
)

latex_table = rf"""\begin{{longtable}}{{{column_format}}}
\label{{tab:device05_analysis_vs_measurement_magnitude_difference}} \\

\toprule
Program &
\multicolumn{{1}}{{c}}{{Measurement}} &
\multicolumn{{1}}{{c}}{{Legacy}} &
\multicolumn{{1}}{{c}}{{Legacy mag.}} &
\multicolumn{{1}}{{c}}{{Clustered}} &
\multicolumn{{1}}{{c}}{{Clustered mag.}} \\
\midrule
\endfirsthead

\toprule
Program &
\multicolumn{{1}}{{c}}{{Measurement}} &
\multicolumn{{1}}{{c}}{{Legacy}} &
\multicolumn{{1}}{{c}}{{Legacy mag.}} &
\multicolumn{{1}}{{c}}{{Clustered}} &
\multicolumn{{1}}{{c}}{{Clustered mag.}} \\
\midrule
\endhead

\midrule
\multicolumn{{6}}{{r}}{{Continued on next page}} \\
\endfoot

\bottomrule
\caption{{Order of magnitude difference between analysis results and measured energy for device D5}}
\endlastfoot

{table_rows}

\end{{longtable}}
"""

output_tex_path = results_directory / "device05_analysis_vs_measurement_magnitude_difference.tex"

with open(output_tex_path, "w", encoding="utf-8") as file:
    file.write(latex_table)

print(f"Saved CSV to {output_csv_path}")
print(f"Saved LaTeX table to {output_tex_path}")