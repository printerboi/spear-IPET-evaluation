from pathlib import Path

import pandas as pd

# Create output directory if it does not exist
results_directory = Path("results")
results_directory.mkdir(parents=True, exist_ok=True)

device_index = 1

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

analysis_directory = Path(f"../../data/device0{device_index}/analysis/raw")


def read_analysis_json(json_path: Path) -> dict | None:
    if not json_path.exists():
        return None

    return pd.read_json(json_path, typ="series").to_dict()


def summarize_main_ilps(analysis_json: dict | None) -> dict[str, int]:
    if analysis_json is None:
        return {
            "ILPs": 0,
            "Constraints": 0,
            "Variables": 0,
        }

    main_function = analysis_json.get("functions", {}).get("main")

    if main_function is None:
        return {
            "ILPs": 0,
            "Constraints": 0,
            "Variables": 0,
        }

    ilps = main_function.get("ILPS", [])

    return {
        "ILPs": len(ilps),
        "Constraints": sum(ilp.get("numConstrains", 0) for ilp in ilps),
        "Variables": sum(ilp.get("numVariables", 0) for ilp in ilps),
    }


def format_integer(value: int | float) -> str:
    if pd.isna(value):
        return "--"

    return f"{int(value)}"


def escape_latex(text: str) -> str:
    return (
        text
        .replace("\\", r"\textbackslash{}")
        .replace("_", r"\_")
        .replace("&", r"\&")
        .replace("%", r"\%")
        .replace("#", r"\#")
        .replace("{", r"\{")
        .replace("}", r"\}")
    )


def format_program_name(program_name: str) -> str:
    return rf"\texttt{{{escape_latex(program_name)}}}"


def create_constraint_latex_row(row: pd.Series) -> str:
    values = [
        format_program_name(str(row["Program"])),
        format_integer(row["Monolithic ILPs"]),
        format_integer(row["Clustered ILPs"]),
        format_integer(row["Monolithic Constraints"]),
        format_integer(row["Clustered Constraints"]),
    ]

    return " & ".join(values) + r" \\"


def create_variable_latex_row(row: pd.Series) -> str:
    values = [
        format_program_name(str(row["Program"])),
        format_integer(row["Monolithic ILPs"]),
        format_integer(row["Clustered ILPs"]),
        format_integer(row["Monolithic Variables"]),
        format_integer(row["Clustered Variables"]),
    ]

    return " & ".join(values) + r" \\"


comparison_rows = []

for program_name in program_names:
    clustered_json_path = analysis_directory / f"{program_name}_clustered_000.json"
    monolithic_json_path = analysis_directory / f"{program_name}_monolithic_000.json"

    clustered_json = read_analysis_json(clustered_json_path)
    monolithic_json = read_analysis_json(monolithic_json_path)

    clustered_summary = summarize_main_ilps(clustered_json)
    monolithic_summary = summarize_main_ilps(monolithic_json)

    comparison_rows.append({
        "Program": program_name,
        "Monolithic ILPs": monolithic_summary["ILPs"],
        "Clustered ILPs": clustered_summary["ILPs"],
        "Monolithic Constraints": monolithic_summary["Constraints"],
        "Clustered Constraints": clustered_summary["Constraints"],
        "Monolithic Variables": monolithic_summary["Variables"],
        "Clustered Variables": clustered_summary["Variables"],
    })

comparison_dataframe = pd.DataFrame(comparison_rows)

comparison_dataframe = comparison_dataframe.sort_values(
    by="Program",
    ascending=True,
).reset_index(drop=True)

output_csv_path = results_directory / "device01_main_ilp_complexity.csv"
comparison_dataframe.to_csv(output_csv_path, index=False)

constraint_column_format = (
    "@{}l"
    "S[table-format=3.0]"
    "S[table-format=3.0]"
    "S[table-format=5.0]"
    "S[table-format=5.0]"
    "@{}"
)

constraint_table_rows = "\n".join(
    create_constraint_latex_row(row)
    for _, row in comparison_dataframe.iterrows()
)

constraint_latex_table = rf"""\begin{{longtable}}{{{constraint_column_format}}}
\label{{tab:device01_main_ilp_constraints}} \\

\toprule
Program &
\multicolumn{{1}}{{c}}{{Mono. ILPs}} &
\multicolumn{{1}}{{c}}{{Clust. ILPs}} &
\multicolumn{{1}}{{c}}{{Mono. constr.}} &
\multicolumn{{1}}{{c}}{{Clust. constr.}} \\
\midrule
\endfirsthead

\toprule
Program &
\multicolumn{{1}}{{c}}{{Mono. ILPs}} &
\multicolumn{{1}}{{c}}{{Clust. ILPs}} &
\multicolumn{{1}}{{c}}{{Mono. constr.}} &
\multicolumn{{1}}{{c}}{{Clust. constr.}} \\
\midrule
\endhead

\midrule
\multicolumn{{5}}{{r}}{{Continued on next page}} \\
\endfoot

\bottomrule
\caption{{Number of constraints generated for the \texttt{{main}} function on device D1}}
\endlastfoot

{constraint_table_rows}

\end{{longtable}}
"""

constraint_output_tex_path = results_directory / "device01_main_ilp_constraints.tex"

with open(constraint_output_tex_path, "w", encoding="utf-8") as file:
    file.write(constraint_latex_table)

variable_column_format = (
    "@{}l"
    "S[table-format=3.0]"
    "S[table-format=3.0]"
    "S[table-format=5.0]"
    "S[table-format=5.0]"
    "@{}"
)

variable_table_rows = "\n".join(
    create_variable_latex_row(row)
    for _, row in comparison_dataframe.iterrows()
)

variable_latex_table = rf"""\begin{{longtable}}{{{variable_column_format}}}
\label{{tab:device01_main_ilp_variables}} \\

\toprule
Program &
\multicolumn{{1}}{{c}}{{Mono. ILPs}} &
\multicolumn{{1}}{{c}}{{Clust. ILPs}} &
\multicolumn{{1}}{{c}}{{Mono. vars.}} &
\multicolumn{{1}}{{c}}{{Clust. vars.}} \\
\midrule
\endfirsthead

\toprule
Program &
\multicolumn{{1}}{{c}}{{Mono. ILPs}} &
\multicolumn{{1}}{{c}}{{Clust. ILPs}} &
\multicolumn{{1}}{{c}}{{Mono. vars.}} &
\multicolumn{{1}}{{c}}{{Clust. vars.}} \\
\midrule
\endhead

\midrule
\multicolumn{{5}}{{r}}{{Continued on next page}} \\
\endfoot

\bottomrule
\caption{{Number of variables generated for the \texttt{{main}} function on device D1}}
\endlastfoot

{variable_table_rows}

\end{{longtable}}
"""

variable_output_tex_path = results_directory / "device01_main_ilp_variables.tex"

with open(variable_output_tex_path, "w", encoding="utf-8") as file:
    file.write(variable_latex_table)

print(f"Saved CSV to {output_csv_path}")
print(f"Saved LaTeX table to {constraint_output_tex_path}")
print(f"Saved LaTeX table to {variable_output_tex_path}")