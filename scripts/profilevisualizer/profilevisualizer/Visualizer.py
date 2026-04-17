import pandas as pd
import plotly.express as px


class Visualizer:
    """
    Simple visualization class that generates a plotly bar chart for a given profile evaluation
    """

    # Path where we will pull the data from
    data_path: str
    # Loaded data
    data: pd.DataFrame

    def __init__(self, path: str, filter: bool):
        """
        Create a new visualizer
        """
        self.data_path = path
        # Load the data
        self._load()

        if filter:
            # Filter the data if requested by the user
            self._filter()


    def show(self):
        """
        Generate the plotly chart
        """
        fig = px.bar(
            self.data,
            x='instruction',
            y='median_value',
            error_y='std_value'
        )
        fig.show()

    def _filter(self):
        """
        Filter the data to remove any meta information that may outscale our actual profile values
        """
        filtered_data_frame = self.data[~self.data["instruction"].str.startswith("_")]
        self.data = filtered_data_frame


    def _load(self):
        """
        Load the data from the path stored in the object
        """
        self.data = pd.read_csv(self.data_path)
