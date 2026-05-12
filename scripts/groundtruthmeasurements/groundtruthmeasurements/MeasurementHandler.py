from datetime import datetime

from energy_toolkit.energy_toolkit import EnergyToolkit, Program
import groundtruthmeasurements.ProgramDefinition
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parents[3]
DATA_DIR = PROJECT_ROOT / "data"

DATAPOINTS=10
REPETITIONS=100

class MeasurementHandler:

    device: str
    toolkit: EnergyToolkit

    def __init__(self, device):
        self.device = device

        output_base_path = DATA_DIR / self.device / "measurements" / "raw"

        self.log(f"Creating new EnergyToolkit component over {DATAPOINTS} datapoints with {REPETITIONS} repetitions.")
        self.log(f"Running on core 0.")
        self.log(f"Storing data to folder {output_base_path}.")

        self.toolkit = EnergyToolkit(datapoints=DATAPOINTS, repetitions=REPETITIONS, core=0, programs=[], resultpath=str(output_base_path))

        

    def run(self):
        programs_arr = self._create_programs()
        self._add_programs_to_toolkit(programs_arr)

        # Run the measurement process
        self.toolkit.measure()

        # Write results and statistics to files
        self.toolkit.write_results()
        self.toolkit.write_statistics()


    def _create_programs(self):
        progList = []

        for progdef in groundtruthmeasurements.ProgramDefinition.program_definitions:
            self.log(f"Found program {progdef["name"]}. Adding it to queue...")
            self.log(progdef["executeable"])
            progList.append(
                Program(progdef["executeable"], progdef["args"], progdef["input"])
            )

        return progList
        

    def _add_programs_to_toolkit(self, programsArr: list[Program]):
        for prog in programsArr:
            self.toolkit.add_program(prog)


    def log(self, msg):
        """
        Log the given msg
        """
        current_time = datetime.now().strftime("%H:%M:%S")
        toprint = "[{current_time}] {msg}".format(current_time=current_time, msg=msg)
        print(toprint)
