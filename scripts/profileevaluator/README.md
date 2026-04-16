# Profile-Evaluator
Run the profile evaluation script. Uses the `config.json` in the project root to calculate a profile.
The process is repeated 10 times, to mitigate OS interference.

## Usage
The script is build using python. Make sure you have python installed.
To run the evaluator create a virtual environment and source it.
```
python -m venv .venv
source .venv/bin/activate
```

Install all needed dependencies:

```
pip install -r requirements.txt
```

Execute the evaluation script using:
```
sudo .venv/bin/python main.py <DEVICE NAME>
```

The script saves the recorded data to the `data/<DEVICE NAME>/profile` directory in the project route.