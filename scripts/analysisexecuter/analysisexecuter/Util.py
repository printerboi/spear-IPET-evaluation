from pathlib import Path

def _aggregate_summary_rows(filename: str, file_suffix: str, analysis_name: str, rows: list):
    """
    Aggregate summary about each analysis type under the given rows
    """
    reference_row = rows[0]
    durations = [row["duration"] for row in rows if row["duration"] is not None]

    average_duration = int(round(sum(durations) / len(durations))) if durations else None
    
    # Construct aggragated row
    return {
        "file": f"{filename}_{file_suffix}.json",
        "analysis": analysis_name,
        "duration": average_duration,
        "main_energy": reference_row["main_energy"],
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

def _find_all_llfiles(basepath):
    """
    Find all files ending in .ll recursively from the given path
    """
    root_path = Path(basepath)
    programs = []

    for file_path in root_path.rglob("*.ll"):
        programs.append(file_path.resolve())

    return programs

def _get_filename_without_extension(file_path):
    """
    Extract the name of the file found under the given path
    """
    path_object = Path(file_path)
    return path_object.stem