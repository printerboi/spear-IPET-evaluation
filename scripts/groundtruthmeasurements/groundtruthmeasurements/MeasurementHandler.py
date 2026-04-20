


class MeasurementHandler:

    device: str

    def __init__(self, device):
        self.device = device
        print(f"New Measurement handler for device {self.device}")

    def run(self):
        print("EXECTUING")