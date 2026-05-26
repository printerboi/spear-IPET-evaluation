

import math
from pathlib import Path
import pandas as pd


results_directory = Path("results")


def create_result_dir():
    # Create output directory if it does not exist
    results_directory.mkdir(parents=True, exist_ok=True)


def get_result_dir():
    return results_directory


def format_scientific(value: float) -> str:
    return f"{value:.3e}"


def format_decimal(value: float) -> str:
    return f"{value:.2f}"

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

def format_milliseconds(value: float) -> str:
    if pd.isna(value):
        return "--"

    return f"{value:.3f}"

def format_magnitude_difference(value: float) -> str:
    if pd.isna(value):
        return "--"

    return f"{value:.2f}"

def calculate_magnitude_difference(measurement: float | None, analysis_value: float | None) -> float | None:
    if measurement is None or analysis_value is None:
        return None

    if measurement <= 0 or analysis_value <= 0:
        return None

    return math.log10(analysis_value / measurement)