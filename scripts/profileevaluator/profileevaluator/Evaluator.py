from datetime import datetime
import subprocess
import json
import os
from pathlib import Path
import pandas as pd

# Paths
PROJECT_ROOT = Path(__file__).resolve().parents[3]
DATA_DIR = PROJECT_ROOT / "data"
CONFIG_PATH = PROJECT_ROOT / "config" / "config.json"


class Evaluator:
    """
    Evaluator class used to calculate multiple profiles
    """

    iterations: int
    device: str
    skipmeasurements: bool

    cpu_vals: list
    syscall_vals: list

    def __init__(self, iterations, device, skipmeasurements):
        """
        Create a new Evaluator
        """
        self.iterations = iterations
        self.device = device
        self.skipmeasurements = skipmeasurements
        self.cpu_vals = []
        self.syscall_vals = []

    def execute(self):
        """
        Run profile evaluation
        """
        self.log("Starting profile evaluation.")

        # Construct paths
        output_base_path = DATA_DIR / self.device / "profile" / "raw"
        output_csv_path = DATA_DIR / self.device / "profile"

        output_base_path.mkdir(parents=True, exist_ok=True)
        output_csv_path.mkdir(parents=True, exist_ok=True)

        # For each iteration
        for i in range(0, self.iterations):
            # Check if the user wants to skip the actual measurement process
            if not self.skipmeasurements:
                self.log(f"Generating profile {i}")
                self._run_profiling(i)

            iteration_name = output_base_path / f"profile_{i}.json"
            
            # Read the recorded profile and construct the dataframes for cpu and syscalls from it
            self.log(f"Constructing dataframes from recorded values profile_{i}.json")
            cpu, syscalls = self._construct_data_frames(iteration_name)

            # Add dataframes to global collection
            self.cpu_vals.append(cpu)
            self.syscall_vals.append(syscalls)

        self.log("Calculating statistics over energy cost...")
        
        # Calculate the average dataframe of each profile component
        cpu_stats, syscall_stats = self._calc_stats()

        # Save calculated average data frames to csv
        cpu_stats.to_csv(output_csv_path / "cpu_stats.csv", index=False)
        syscall_stats.to_csv(output_csv_path / "syscall_stats.csv", index=False)


    def _run_profiling(self, iteration_index):
        """
        Run the profiling calculation using spear
        """

        # Construct paths
        output_base_path = DATA_DIR / self.device / "profile" / "raw"
        output_base_path.mkdir(parents=True, exist_ok=True)

        # Open a new subprocess running spear
        process = subprocess.Popen(
            [
                "spear",
                "profile",
                "--config", str(CONFIG_PATH),
                "--model", "/etc/spear/profile/",
                "--savelocation", str(output_base_path)
            ],
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,  # merge stderr into stdout
            text=True,
            bufsize=1  # line-buffered
        )

        # Stream output to stdout
        for line in iter(process.stdout.readline, ""):
            print(line, end="")

        process.stdout.close()
        process.wait()

        # Catch any error
        if process.returncode != 0:
            raise RuntimeError(f"Profiling failed with exit code {process.returncode}")

        generated_profile = output_base_path / "profile.json"
        iteration_name = output_base_path / f"profile_{iteration_index}.json"

        # Rename the generated profile to distinguish different interations
        os.rename(generated_profile, iteration_name)

    def _construct_data_frames(self, file_path):
        """
        Read a json file and construct a dataframe from it
        """
        with open(file_path, "r", encoding="utf-8") as json_file:
            parsed_data = json.load(json_file)

        # Parse CPU values
        cpu_metrics = parsed_data["cpu"]
        cpu_dataframe = pd.DataFrame(list(cpu_metrics.items()), columns=["instruction", "value"])
        
        # Parse syscalls 
        syscall_metrics = parsed_data["syscalls"]
        syscall_dataframe = pd.DataFrame(list(syscall_metrics.items()), columns=["syscall", "value"])

        return cpu_dataframe, syscall_dataframe
    
    def _calc_stats(self):
        # Concat the frames
        cpu_concatenated = pd.concat(self.cpu_vals, ignore_index=True)
        syscall_concatenated = pd.concat(self.syscall_vals, ignore_index=True)

        # CPU stats
        cpu_stats = (
            cpu_concatenated
            .groupby("instruction")
            .agg(
                median_value=("value", "median"),
                mean_value=("value", "mean"),
                std_value=("value", "std"),
                var_value=("value", "var"),
                min_value=("value", "min"),
                max_value=("value", "max")
            )
            .reset_index()
        )

        cpu_stats["coefficient_of_variation"] = (
            cpu_stats["std_value"] / cpu_stats["mean_value"]
        )

        # Syscall stats
        syscall_stats = (
            syscall_concatenated
            .groupby("syscall")
            .agg(
                median_value=("value", "median"),
                mean_value=("value", "mean"),
                std_value=("value", "std"),
                var_value=("value", "var"),
                min_value=("value", "min"),
                max_value=("value", "max")
            )
            .reset_index()
        )

        syscall_stats["coefficient_of_variation"] = (
            syscall_stats["std_value"] / syscall_stats["mean_value"]
        )

        return cpu_stats, syscall_stats

    def _calculate_coefvariance(self):
        """
        Calculate coefficient of variation (std / mean) per entity
        over all recorded cpu and syscall dataframes
        """
        # Concat the frames
        cpu_concatenated = pd.concat(self.cpu_vals, ignore_index=True)
        syscall_concatenated = pd.concat(self.syscall_vals, ignore_index=True)

        # CPU: compute mean and std per instruction
        cpu_statistics = (
            cpu_concatenated
            .groupby("instruction")["value"]
            .agg(mean_value="mean", std_value="std")
            .reset_index()
        )

        cpu_statistics["coefficient_of_variation"] = (
            cpu_statistics["std_value"] / cpu_statistics["mean_value"]
        )

        # Syscall: compute mean and std per syscall
        syscall_statistics = (
            syscall_concatenated
            .groupby("syscall")["value"]
            .agg(mean_value="mean", std_value="std")
            .reset_index()
        )

        syscall_statistics["coefficient_of_variation"] = (
            syscall_statistics["std_value"] / syscall_statistics["mean_value"]
        )

        return cpu_statistics, syscall_statistics

    def log(self, msg):
        """
        Log helper function
        """
        current_time = datetime.now().strftime("%H:%M:%S")
        toprint = "[{current_time}] {msg}".format(current_time=current_time, msg=msg)
        print(toprint)