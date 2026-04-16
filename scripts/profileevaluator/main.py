import click
from profileevaluator.Evaluator import Evaluator

# Measurement repetitions
DEFAULT_REPETITIONS = 10

@click.command()
@click.argument("device_name")
@click.option(
    "--skip-measurements",
    is_flag=True,
    default=False,
    help="Skip measurements during evaluation."
)
@click.option(
    "--repetitions",
    default=DEFAULT_REPETITIONS,
    show_default=True,
    help="Number of repetitions for the evaluation."
)
def main(device_name: str, skip_measurements: bool, repetitions: int):
    """
    Run the evaluator with the given DEVICE_NAME.

    DEVICE_NAME: Name of the device to evaluate.
    """
    # Initialize evaluator with provided CLI arguments
    evaluator = Evaluator(repetitions, device_name, skip_measurements)
    evaluator.log(f"Running profiling for device {device_name}")

    # Execute evaluation process
    evaluator.execute()


if __name__ == "__main__":
    main()