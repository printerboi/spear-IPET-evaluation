from pathlib import Path

def _aggregate_summary_rows(filename: str, file_suffix: str, analysis_name: str, rows: list):
    """
    Aggregate summary about each analysis type under the given rows
    """
    durations = [row["duration"] for row in rows if row["duration"] is not None]
    main_energies = [row["main_energy"] for row in rows if row["main_energy"] is not None]

    average_duration = int(round(sum(durations) / len(durations))) if durations else None
    average_main_energy = sum(main_energies) / len(main_energies) if main_energies else None

    return {
        "file": f"{filename}_{file_suffix}.json",
        "analysis": analysis_name,
        "duration": average_duration,
        "main_energy": average_main_energy,
    }

def _aggregate_function_rows(filename: str, file_suffix: str, analysis_name: str, rows: list):
    """
    Aggregate summaries about functions under the given rows
    """

    rows_by_function_name = {}

    for row in rows:
        function_name = row["function_name"]
        rows_by_function_name.setdefault(function_name, []).append(row)

    aggregated_rows = []

    for function_name in sorted(rows_by_function_name.keys()):
        function_rows = rows_by_function_name[function_name]
        reference_row = function_rows[0]
        durations = [row["duration"] for row in function_rows if row["duration"] is not None]

        average_duration = int(round(sum(durations) / len(durations))) if durations else None

        aggregated_rows.append({
            "file": f"{filename}_{file_suffix}.json",
            "analysis": analysis_name,
            "duration": average_duration,
            "function_name": function_name,
            "energy": reference_row["energy"],
            "num_nodes": reference_row["num_nodes"],
            "num_ilps": reference_row["num_ilps"],
            "total_constraints": reference_row["total_constraints"],
            "total_variables": reference_row["total_variables"],
        })

    return aggregated_rows

def _find_all_llfiles(base_path):
    """
    Find all files ending in .ll recursively from the given path,
    excluding any files inside a 'dependencies' directory.
    """
    root_path = Path(base_path)
    programs = []

    for file_path in root_path.rglob("*.ll"):
        # Skip files that are inside a 'dependencies' directory
        if "dependencies" in file_path.parts:
            continue

        programs.append(file_path.resolve())

    return programs

def _get_filename_without_extension(file_path):
    """
    Extract the name of the file found under the given path
    """
    path_object = Path(file_path)
    return path_object.stem