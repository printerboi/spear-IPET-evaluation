from datetime import datetime
import subprocess
import json
import os
from pathlib import Path
from analysisexecuter.Util import _find_all_llfiles, _aggregate_function_rows, _aggregate_summary_rows, _get_filename_without_extension
import pandas as pd


# Paths
PROJECT_ROOT = Path(__file__).resolve().parents[3]
DATA_DIR = PROJECT_ROOT / "data"
CONFIG_PATH_WITHOUT_CACHE = PROJECT_ROOT / "config.json"
CONFIG_PATH_WITH_CACHE = PROJECT_ROOT / "config_cache.json"
PROFILE_PATH = PROJECT_ROOT / "profile.json"
PROGRAM_PATH = PROJECT_ROOT / "evaluation_programs"
TMP_PATH_STR = "/tmp/spear"
CLUSTER_CACHE_PATH = Path(__file__).resolve().parents[1] / "cluster_cache.json"

# Constants
REPETITIONS=5


class Executer:
    """
    Analysis evaluation executer
    """

    # Name of the device we are running on
    device_name: str

    def __init__(self, device: str):
        """
        Create a new clean Executer component
        """
        self.device_name = device

    def run(self):
        """
        Run the evaluation process
        """
        self.log("Starting analysis evaluation.")

        # Define the output paths and create them if possible
        output_base_path = DATA_DIR / self.device_name / "analysis" / "raw"
        output_csv_path = DATA_DIR / self.device_name / "analysis"

        output_base_path.mkdir(parents=True, exist_ok=True)
        output_csv_path.mkdir(parents=True, exist_ok=True)

        # Search for the .ll files in the folder where we are expecting the evaluation program files
        programs = _find_all_llfiles(PROGRAM_PATH)

        for program_path in programs:
            # Run the analysis for the found program
            self._run_benchmark(program_path)

        print(CLUSTER_CACHE_PATH)
        self._remove_cluster_cache()


    def _run_benchmark(self, program: Path):
        """
        Execute all of our analysis variants on the given program path
        """

        # Query the name of the file under analysis
        filename = _get_filename_without_extension(program)

        # Lists for saving recording values
        uncached_summary_runs = []
        uncached_function_runs = []

        cached_summary_runs = []
        cached_function_runs = []

        self.log(f"Running uncached benchmark for {filename}")
        # Deleta a cache file if one already exists
        self._remove_cluster_cache()

        # Repeat the uncached analysis multiple times
        for repetition_index in range(REPETITIONS):
            self.log(f"Uncached repetition {repetition_index + 1}/{REPETITIONS}")

            # Execute the SPEAR comparison analysis
            self._spear_runner(program, CONFIG_PATH_WITHOUT_CACHE)

            # Collect the recorded results
            summary_rows, function_rows = self._collect_uncached_run_results(filename, repetition_index)

            # Append the recorded values to our lists
            uncached_summary_runs.append(summary_rows)
            uncached_function_runs.append(function_rows)

        """
        Execute spear once with cache enabled. This warms up the cache and fills the cluster_cache.json
        with actual values, subsequent analyses will use.
        We record no values here as this is only done to see the effect of the cache more directly
        """
        self.log(f"Running cache warm-up for {filename}")
        self._remove_cluster_cache()
        # Execute cached variant once
        self._spear_runner(program, CONFIG_PATH_WITH_CACHE)
        
        # Execute cached variant multiple times with warm cache
        self.log(f"Running warm cached benchmark for {filename}")
        for repetition_index in range(REPETITIONS):
            self.log(f"Cached repetition {repetition_index + 1}/{REPETITIONS}")
            # Execute spear
            self._spear_runner(program, CONFIG_PATH_WITH_CACHE)

            # Collect recorded resultsw
            summary_row, function_rows = self._collect_cached_run_results(filename, repetition_index)

            # Append results to our lists
            cached_summary_runs.append(summary_row)
            cached_function_runs.append(function_rows)

        # Aggregate all recorded values from our lists to form a comprehension table
        aggregated_summary_rows, aggregated_function_rows = self._aggregate_results(
            filename=filename,
            uncached_summary_runs=uncached_summary_runs,
            uncached_function_runs=uncached_function_runs,
            cached_summary_runs=cached_summary_runs,
            cached_function_runs=cached_function_runs
        )

        # Define the path where we will store the generated csv file
        output_csv_path = DATA_DIR / self.device_name / "analysis"
        output_csv_path.mkdir(parents=True, exist_ok=True)

        # Convert the data to dataframes
        summary_dataframe = pd.DataFrame(aggregated_summary_rows)
        functions_dataframe = pd.DataFrame(aggregated_function_rows)

        # Define the filenames
        summary_csv_path = output_csv_path / f"{filename}_analysis_summary.csv"
        functions_csv_path = output_csv_path / f"{filename}_analysis_functions.csv"

        # Store the frames as csv file
        summary_dataframe.to_csv(summary_csv_path, index=False)
        functions_dataframe.to_csv(functions_csv_path, index=False)

    def _spear_runner(self, program: Path, config: Path):
        """
        Execute spears analyse command with the given config on the given program
        """

        # Create a new process
        process = subprocess.Popen(
            [
                "spear",
                "analyze",
                "--profile", str(PROFILE_PATH),
                "--config", str(config),
                "--program", str(program)
            ],
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            bufsize=1
        )

        # Print the output
        for line in iter(process.stdout.readline, ""):
            print(line, end="")

        # Cleanup the process afterward
        process.stdout.close()
        process.wait()

        # Detect any runtime errors
        if process.returncode != 0:
            raise RuntimeError(f"Analysis failed with exit code {process.returncode}")

    def _collect_uncached_run_results(self, filename: str, iteration_number: int):
        """
        Collect the recorded data from the uncached analysis for the given filename under the 
        given iteration_number
        """

        # TMP path where the analysis result is initially stored
        tmp_path = Path(TMP_PATH_STR)

        # Define the path where we want to store the results
        output_base_path = DATA_DIR / self.device_name / "analysis" / "raw"
        output_base_path.mkdir(parents=True, exist_ok=True)

        # Define the paths of each analysis type
        analysis_paths = [
            ("legacy", tmp_path / f"{filename}_legacy.json"),
            ("clustered", tmp_path / f"{filename}_clustered.json"),
            ("monolithic", tmp_path / f"{filename}_monolithic.json"),
        ]

        summary_rows = []
        function_rows = []

        # Iterate over the types of analysis we are inspecting here
        for analysis_key, tmp_file_path in analysis_paths:
            # Build destination path
            destination_path = output_base_path / f"{filename}_{analysis_key}_{iteration_number:03d}.json"

            # Move file from /tmp to raw/
            os.rename(tmp_file_path, destination_path)

            # Parse moved file
            summary_row, parsed_function_rows = self.parse_analysis_file(destination_path)
            summary_row["analysis_key"] = analysis_key

            # Set the analysis key
            for function_row in parsed_function_rows:
                function_row["analysis_key"] = analysis_key

            # Append the parsed results
            summary_rows.append(summary_row)
            function_rows.extend(parsed_function_rows)

        return summary_rows, function_rows

    def _collect_cached_run_results(self, filename: str, iteration_number: int):
        """
        Collect the recorded data from the cached analysis for the given filename under the 
        given iteration_number
        """
        # TMP path where the analysis result is initially stored
        tmp_path = Path(TMP_PATH_STR)
        # Filename found in the tmp dir
        cache_tmp_path = tmp_path / f"{filename}.json"

        # /raw dir, where we want to store the result
        output_base_path = DATA_DIR / self.device_name / "analysis" / "raw"
        output_base_path.mkdir(parents=True, exist_ok=True)

        # Build destination path
        destination_path = output_base_path / f"{filename}_cache_{iteration_number:03d}.json"

        # Move the file
        os.rename(cache_tmp_path, destination_path)

        # Parse from the moved file
        summary_row, function_rows = self.parse_analysis_file(destination_path)
        # Set the analysis key
        summary_row["analysis_key"] = "cache"

        for function_row in function_rows:
            function_row["analysis_key"] = "cache"

        return summary_row, function_rows

    def _aggregate_results(self, filename: str, uncached_summary_runs: list, uncached_function_runs: list, cached_summary_runs: list, cached_function_runs: list):
        """
        Summarize the results for one given program with the given recorded results.
        Creates the datastructure we want to store in a .csv file later
        """
        
        # Groups we are summarizing on
        summary_groups = {
            "legacy": [],
            "clustered": [],
            "monolithic": [],
            "cache": [],
        }

        # Function aggregation obect
        function_groups = {
            "legacy": [],
            "clustered": [],
            "monolithic": [],
            "cache": [],
        }

        # Collect all uncached results and store them under the respective analysis key
        for repetition_summary_rows in uncached_summary_runs:
            for summary_row in repetition_summary_rows:
                summary_groups[summary_row["analysis_key"]].append(summary_row)

        # Collect all uncached function results and store them under the respective analysis key
        for repetition_function_rows in uncached_function_runs:
            for function_row in repetition_function_rows:
                function_groups[function_row["analysis_key"]].append(function_row)

        # Store the cached results in the summary
        for summary_row in cached_summary_runs:
            summary_groups["cache"].append(summary_row)

        # Store the cached results for functions 
        for repetition_function_rows in cached_function_runs:
            for function_row in repetition_function_rows:
                function_groups["cache"].append(function_row)

        aggregated_summary_rows = [
            _aggregate_summary_rows(filename, "legacy", "legacy", summary_groups["legacy"]),
            _aggregate_summary_rows(filename, "clustered", "clustered", summary_groups["clustered"]),
            _aggregate_summary_rows(filename, "monolithic", "monolithic", summary_groups["monolithic"]),
            _aggregate_summary_rows(filename, "cache", "clustered", summary_groups["cache"]),
        ]

        aggregated_function_rows = []
        aggregated_function_rows.extend(
            _aggregate_function_rows(filename, "legacy", "legacy", function_groups["legacy"])
        )
        aggregated_function_rows.extend(
            _aggregate_function_rows(filename, "clustered", "clustered", function_groups["clustered"])
        )
        aggregated_function_rows.extend(
            _aggregate_function_rows(filename, "monolithic", "monolithic", function_groups["monolithic"])
        )
        aggregated_function_rows.extend(
            _aggregate_function_rows(filename, "cache", "clustered", function_groups["cache"])
        )

        return aggregated_summary_rows, aggregated_function_rows


    def parse_analysis_file(self, file_path: Path):
        """
        Parse a given analysis result found under the given path
        """

        # Open the file
        with open(file_path, "r", encoding="utf-8") as json_file:
            # Load the json data
            json_data = json.load(json_file)
        
        # Extract top-level information
        analysis_name = json_data.get("analysis", Path(file_path).stem)
        duration = json_data.get("duration", None)
        functions = json_data.get("functions", {})

        summary_row = {
            "file": os.path.basename(file_path),
            "analysis": analysis_name,
            "duration": duration,
            "main_energy": functions["main"]["energy"]
        }

        # Extract information about the functions
        function_rows = []
        for function_name, function_data in functions.items():
            # Extract ILP information
            ilp_entries = function_data.get("ILPS", [])
            total_constraints = sum(ilp_entry.get("numConstrains", 0) for ilp_entry in ilp_entries)
            total_variables = sum(ilp_entry.get("numVariables", 0) for ilp_entry in ilp_entries)

            # Append the information about the function
            function_rows.append({
                "file": os.path.basename(file_path),
                "analysis": analysis_name,
                "duration": duration,
                "function_name": function_name,
                "energy": function_data.get("energy", 0.0),
                "num_nodes": len(function_data.get("nodes", [])),
                "num_ilps": len(ilp_entries),
                "total_constraints": total_constraints,
                "total_variables": total_variables,
            })

        return summary_row, function_rows

    def _remove_cluster_cache(self):
        """
        Delete the cluster cache if it exists
        """
        if CLUSTER_CACHE_PATH.exists():
            CLUSTER_CACHE_PATH.unlink()

    def log(self, msg):
        """
        Log the given msg
        """
        current_time = datetime.now().strftime("%H:%M:%S")
        toprint = "[{current_time}] {msg}".format(current_time=current_time, msg=msg)
        print(toprint)

