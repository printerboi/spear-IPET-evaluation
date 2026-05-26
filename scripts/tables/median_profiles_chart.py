from pathlib import Path

import pandas as pd
import plotly.express as px

results_directory = Path("results")
results_directory.mkdir(parents=True, exist_ok=True)

selected_instructions = [
    "add", "alloca", "and", "br", "call",
    "fadd", "fdiv", "fsub", "icmp eq", "load",
    "mul", "or", "sdiv", "select", "sext",
    "shl", "srem", "store", "sub", "udiv",
]

csv_path = Path("../../data/device05/profile/cpu_stats.csv")
device_dataframe = pd.read_csv(csv_path)

plot_dataframe = device_dataframe[
    device_dataframe["instruction"].isin(selected_instructions)
].copy()

plot_dataframe["instruction"] = pd.Categorical(
    plot_dataframe["instruction"],
    categories=selected_instructions,
    ordered=True,
)

plot_dataframe = plot_dataframe.sort_values("instruction").reset_index(drop=True)

figure = px.bar(
    plot_dataframe,
    x="instruction",
    y="median_value",
    error_y="std_value",
    labels={
        "instruction": "Instruction",
        "median_value": "Median energy [J]",
    },
    title="Median instruction energy profile for Device 05",
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

#figure.update_yaxes(type="log")

output_html_path = results_directory / "device05_instruction_profile.html"
figure.write_html(output_html_path)

output_pdf_path = results_directory / "device05_instruction_profile.pdf"
figure.write_image(output_pdf_path)

print(f"Saved interactive chart to {output_html_path}")
print(f"Saved PDF chart to {output_pdf_path}")