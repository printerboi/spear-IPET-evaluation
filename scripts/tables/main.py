from pathlib import Path

from tables.generators.instruction_values_of_singular_device import SingularDeviceAllValuesTable
from tables.generators.analysis_results import AnalysisResultTable
from tables.generators.analysis_runtimes import AnalysisRuntimeTable
from tables.generators.cov_per_device import CoVTable
from tables.generators.compare_analysis_measurement import AnalysisComparisonTable
from tables.generators.ilp_comparison import ILPComparisonTable

from tables.util.Utility import create_result_dir

def main():
    print("Ensuring the result directory exists...")
    create_result_dir()
    print("Generating ressources...")
    SingularDeviceAllValuesTable().generate()
    AnalysisResultTable().generate()
    AnalysisRuntimeTable().generate()
    CoVTable().generate()
    AnalysisComparisonTable().generate()
    ILPComparisonTable().generate()

if __name__ == "__main__":
    main()