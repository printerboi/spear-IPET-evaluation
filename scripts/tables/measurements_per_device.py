from pathlib import Path

import pandas as pd

# Create output directory if it does not exist
results_directory = Path("results")
results_directory.mkdir(parents=True, exist_ok=True)

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

measurement_rows = []

for program_index, program_name in enumerate(program_names):
    measurement_row = {
        "Program": program_name,
    }

    for device_index in range(1, 6):
        statistics_path = Path(
            f"../../data/device0{device_index}/measurements/raw/{program_index}/statistics.csv"
        )

        if not statistics_path.exists():
            measurement_row[f"D{device_index}"] = None
            continue

        statistics_dataframe = pd.read_csv(statistics_path)

        print(statistics_dataframe)

        mean_row = statistics_dataframe[
            statistics_dataframe["# Value"] == "mean"
        ]

        if mean_row.empty:
            measurement_row[f"D{device_index}"] = None
        else:
            measurement_row[f"D{device_index}"] = mean_row.iloc[0]["Energy"]

    measurement_rows.append(measurement_row)

measurement_dataframe = pd.DataFrame(measurement_rows)

measurement_dataframe = measurement_dataframe[
    ["Program", "D1", "D2", "D3", "D4", "D5"]
]

output_csv_path = results_directory / "measured_energy_per_device.csv"
measurement_dataframe.to_csv(output_csv_path, index=False)


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
        format_scientific(row["D1"]),
        format_scientific(row["D2"]),
        format_scientific(row["D3"]),
        format_scientific(row["D4"]),
        format_scientific(row["D5"]),
    ]

    return " & ".join(values) + r" \\"


column_format = (
    "@{}l"
    "S[table-format=1.3e-2]"
    "S[table-format=1.3e-2]"
    "S[table-format=1.3e-2]"
    "S[table-format=1.3e-2]"
    "S[table-format=1.3e-2]"
    "@{}"
)

table_rows = "\n".join(
    create_latex_row(row)
    for _, row in measurement_dataframe.iterrows()
)

latex_table = rf"""\begin{{longtable}}{{{column_format}}}
\label{{tab:measured_energy_per_device}} \\

\toprule
Program &
\multicolumn{{1}}{{c}}{{D1}} &
\multicolumn{{1}}{{c}}{{D2}} &
\multicolumn{{1}}{{c}}{{D3}} &
\multicolumn{{1}}{{c}}{{D4}} &
\multicolumn{{1}}{{c}}{{D5}} \\
\midrule
\endfirsthead

\toprule
Program &
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
\caption{{Measured mean energy per benchmark and device}}
\endlastfoot

{table_rows}

\end{{longtable}}
"""

output_tex_path = results_directory / "measured_energy_per_device.tex"

with open(output_tex_path, "w", encoding="utf-8") as file:
    file.write(latex_table)

print(f"Saved CSV to {output_csv_path}")
print(f"Saved LaTeX table to {output_tex_path}")