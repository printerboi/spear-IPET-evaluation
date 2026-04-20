import click
from groundtruthmeasurements.MeasurementHandler import MeasurementHandler

@click.command()
@click.argument("device_name")
def main(device_name: str):
    """
    Run the evaluator with the given DEVICE_NAME.

    DEVICE_NAME: Name of the device to evaluate.
    """
    executer = MeasurementHandler(device_name)
    executer.run()


if __name__ == "__main__":
    main()