from datetime import datetime
import subprocess
import json
import os
from pathlib import Path
import pandas as pd

# Paths
PROJECT_ROOT = Path(__file__).resolve().parents[3]
DATA_DIR = PROJECT_ROOT / "data"
CONFIG_PATH = PROJECT_ROOT / "config.json"
PROFILE_PATH = PROJECT_ROOT / "profile.json"
PROGRAM_PATH = PROJECT_ROOT / "evaluation_programs"
TMP_PATH_STR = "/tmp/spear"

class Executer:
    device_name: str

    def __init__(self, device: str):
        self.device_name = device

    def run(self):
        self.log("Starting analysis evaluation.")

        # Construct paths
        output_base_path = DATA_DIR / self.device_name / "analysis" / "raw"
        output_csv_path = DATA_DIR / self.device_name / "analysis"

        output_base_path.mkdir(parents=True, exist_ok=True)
        output_csv_path.mkdir(parents=True, exist_ok=True)

        progs = self._find_all_llfiles(PROGRAM_PATH)

        for progpath in progs:
            self._run_analysis(progpath)
        
        

    def _run_analysis(self, program):
        # Construct paths
        output_base_path = DATA_DIR / self.device_name / "analysis" / "raw"
        output_base_path.mkdir(parents=True, exist_ok=True)

        # Open a new subprocess running spear
        process = subprocess.Popen(
            [
                "spear",
                "analyze",
                "--profile", str(PROFILE_PATH),
                "--config", str(CONFIG_PATH),
                "--program", str(program)
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
            raise RuntimeError(f"Analysis failed with exit code {process.returncode}")
        
        filename = self._get_filename_without_extension(program)
        print(filename)

        TMP_PATH = Path(TMP_PATH_STR)

        tmp_paths = [
            ("legacy", TMP_PATH / f"{filename}_legacy.json"),
            ("clustered", TMP_PATH / f"{filename}_clustered.json"),
            ("monolithic", TMP_PATH / f"{filename}_monolithic.json"),
        ]

        for tmpfile_tuple in tmp_paths:
            analysis_type = tmpfile_tuple[0]
            tmpfile = tmpfile_tuple[1]

            eval_file = output_base_path / f"analysis_{analysis_type}.json"

            # Rename the generated analysis result
            os.rename(tmpfile, eval_file)

        
    def _find_all_llfiles(self, basepath):
        root_path = Path(basepath)
        programs = []

        # rglob searches recursively
        for file_path in root_path.rglob("*.ll"):
            programs.append(file_path.resolve())

        return programs

    def log(self, msg):
        """
        Log helper function
        """
        current_time = datetime.now().strftime("%H:%M:%S")
        toprint = "[{current_time}] {msg}".format(current_time=current_time, msg=msg)
        print(toprint)

    def _get_filename_without_extension(self, file_path):
        path_object = Path(file_path)
        return path_object.stem  # filename without extension