from pathlib import Path

import pandas as pd
import plotly.express as px

from tables.util.Instructions import get_selected_instructions
from tables.util.Utility import get_result_dir


device_id = 5


class MedianProfileChart:
    selected_instructions = get_selected_instructions()
    csv_path = Path(f"../../data/device0{device_id}/profile/cpu_stats.csv")
    result_directory = get_result_dir()

    def create_plot_dataframe(self):
        device_dataframe = pd.read_csv(self.csv_path)

        plot_dataframe = device_dataframe[
            device_dataframe["instruction"].isin(self.selected_instructions)
        ].copy()

        plot_dataframe["instruction"] = pd.Categorical(
            plot_dataframe["instruction"],
            categories=self.selected_instructions,
            ordered=True,
        )

        plot_dataframe = plot_dataframe.sort_values("instruction").reset_index(drop=True)

        return plot_dataframe

    def create_figure(self, plot_dataframe):
        figure = px.bar(
            plot_dataframe,
            x="instruction",
            y="median_value",
            error_y="std_value",
            labels={
                "instruction": "Instruction",
                "median_value": "Median energy [J]",
            },
            title=f"Median instruction energy profile for Device 0{device_id}",
        )

        figure.update_traces(
            marker_color="#639A00",
            marker_line_width=1,
        )

        figure.update_layout(
            title_font_size=24,
            font_size=18,
            xaxis_tickangle=-45,
            yaxis_tickformat=".3e",
            bargap=0.15,
            width=1400,
            height=600,
            showlegend=False,
        )

        figure.update_xaxes(
            title_font_size=22,
            tickfont_size=18,
        )

        figure.update_yaxes(
            title_font_size=22,
            tickfont_size=18,
        )

        return figure

    def generate(self):
        plot_dataframe = self.create_plot_dataframe()
        figure = self.create_figure(plot_dataframe)

        output_html_path = self.result_directory / f"device0{device_id}_instruction_profile.html"
        figure.write_html(output_html_path)

        output_pdf_path = self.result_directory / f"device0{device_id}_instruction_profile.pdf"
        figure.write_image(output_pdf_path)

        print(f"Saved interactive chart to {output_html_path}")
        print(f"Saved PDF chart to {output_pdf_path}")