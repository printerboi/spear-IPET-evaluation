# SPEAR-IPET-evaluation

Welcome to the SPEAR-IPET evaluation repository. This repository contains all programs and data required for the evaluation conducted as part of the master’s thesis "*...*".

## Structure

The repository is organized into the following components:

```text
project-root/
│
├── ansible/                # Ansible playbooks for setting up a new evaluation device
│
├── data/                   # Experimental data collected during evaluation runs
│
├── evaluation_programs/    # Programs used to perform the evaluation
│
└── scripts/                # Scripts for automation (e.g., visualization, data aggregation)
```

## Hardware recommendations

While SPEAR and the evaluation is in general device agnostic, we designed our deployment in this repository specifically for **Ubuntu 24.04**. If you want to use SPEAR and the evaluation on another linux based distribution, please refer for the manual installation of [SPEAR](#)

## Setting up a device

We added an ansible playbook to make the evaluation more streamlined and in order to reduce setup overhead.
To guarantee the easy setup of a device use the following steps. Moving on we use the term "host machine" for the device you are currently working on that will execute the ansible playbook on another device. The other device is called the "evaluation machine".

1) **Install Ansible**

Make sure you have ansible installed on your host machine. If it is not installed, use your favourite package manager to get the dependency.

2) **OpenSSH Server**

On the evaluation machine make sure that you have a valid OpenSSH-Server package and that the SSH-Server is running and can be connected to.

3) **Generate a SSH-Key and Copy it to the evaluation machine**
On the host machine generate a SSH-Key using
```
ssh-keygen
```
Make sure you give it a valid name and path. Use an algorithm that suits the evaluation machine you are trying to connect to.
Copy the key over to the machine using
```
ssh-copy-id -i <path_to_your_key> user@host
```
This will use the key located under `<path_to_your_key>` and copy it to the user on the evaluation machine found at the address `host`.
Test your ssh-connection using:
```
ssh -i <path_to_your_key> user@host
```
If the connection works without a login, the key authentication works.

4) **Setting up the ansible script**
Locate the `ansible` folder in a terminal and edit the `inventory.yml` file.
Create a new device entry for your evaluation machine:
```
<device_name>:
    ansible_user: <user>
    ansible_host: <ip>
    ansible_connection: ssh
    ansible_python_interpreter: /usr/bin/python3
    ansible_ssh_private_key_file: ./.ssh_deploy_key
    prefix_path: /opt/sselabs
    is_pipeline: false
    skip_phasar: false
```
Fill in `<device_name>` with a meaningfull unqique identitfier. Add `<user>` as the user you previously copied the ssh key to.
Supply the ip or hostname `<ip>` the evaluation device will be reachable on.

5) **Deploy the playbook**

In order to deploy the ansible playbook, we created a custom deploy script. Call it with the unique identifier of you evaluation machine and the deployment should start:

```
./deploy <device_name>
```

Expect the deployment to take some time depending on the hardware setup you are deploying to.

## Executing the Evaluation

Our evaluation is split into two parts. The whole process is described by the following diagram:

![](assets/SPEAR_evaluation.jpg)

In order to run the evaluation, we prepared multiple evaluation scripts using python.

### Running the Profile Evaluation

To evaluate the profile generation on an evaluation device execute the script `profileevaluator`.
First, navigate into the respective subfolder:
```
cd scripts/profileevaluator
```
Create a virtual environment and source the respective environment
```
python -m venv .venv
source .venv/bin/activate
```
Install the needed dependencies
```
pip install -r requirements.txt
```
Run the script using:
```
sudo .venv/bin/python main.py <Name of the eval device>
```
Choose a meaningful and unique name for `<Name of the eval device>`. The name will be used to store the data generated during the evaluation.

After the evaluation is done, the results can be found in `/opt/sselabs/data/<Name of the eval device>/profile`. The folder `raw` stores all recorded raw profiles during the evaluation.
The file `cpu_stats.csv` provides a summary over all recorded CPU profiles. Additionally, the file `syscall_stats.csv` describes a summary of all system call related values.

### Running the Analysis Evaluation

The analysis can be evaluated using the script `analysisexecuter`.
Navigate into the subfolder:
```
cd scripts/analysisexecuter
```
Create a virtual environment and source it
```
python -m venv .venv
source .venv/bin/activate
```
Install the needed dependencies
```
pip install -r requirements.txt
```
Run the script using:
```
sudo .venv/bin/python main.py <Name of the eval device>
```
Choose a meaningful and unique name for `<Name of the eval device>`. The name will be used to store the data generated during the evaluation.

After the evaluation is done, the results can be found in `/opt/sselabs/data/<Name of the eval device>/analysis`. The analysis folder contains the recorded values in the folder `raw`.
Comprehensive tables are provided as `.csv` format for each program under analysis. `<program name>_analysis_functions.csv` provides an overview over all analyzed functions.
For each analysis method `legacy`, `clustered`, `monolithic` and `clustered cached`, the analyzed energy value as well as information about the ILPs (if used by the
method) are provided. Additionally, the file `<program name>_analysis_summary` provides a summary of energy calculated for the `main` function of the program for each analysis method.

### Running the RAPL Measurement

The analysis can be evaluated using the script `groundtruthmeasurements`.
Navigate into the subfolder:
```
cd scripts/groundtruthmeasurements
```
Create a virtual environment and source it
```
python -m venv .venv
source .venv/bin/activate
```
Install the needed dependencies
```
pip install -r requirements.txt
```
Run the script using:
```
sudo .venv/bin/python main.py <Name of the eval device>
```
Choose a meaningful and unique name for `<Name of the eval device>`. The name will be used to store the data generated during the evaluation.

After the evaluation is done, the results can be found in `/opt/sselabs/data/<Name of the eval device>/measurements/raw`. Each program under analysis is indexed. The results recorded
during the measurement are stored for each program in the folder with the respective id. In each id-folder two `.csv` files are stored. `result.csv` stores the recorded energy values and
execution durations of the measurement. The file `statistics.csv` stores a summary over the resulted values.

## Collecting Data

In order to collect data, make sure the needed tools are installed. Use the provided ansible script to simplify the installation process. For each device that should be evaluated
create a unique identifier that will be used to store the results. Make sure the evaluation device runs a clean OS-Install with no other programs than stock Ubuntu 24.04 and the 
software provided by this evaluation.

## Our collected data