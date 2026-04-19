#!/bin/bash

set -e
set -o pipefail

# Ask user for SSH key name
read -p "Enter the SSH key name (e.g. id_rsa, id_ed25519): " ssh_key_name

# Define source paths
private_key_source="$HOME/.ssh/$ssh_key_name"
public_key_source="$HOME/.ssh/${ssh_key_name}.pub"

# Define project-local key names (safe to ignore in git)
project_private_key="./.ssh_deploy_key"
project_public_key="./.ssh_deploy_key.pub"

# Validate existence
if [[ ! -f "$private_key_source" ]]; then
    echo "Error: Private key not found at $private_key_source"
    exit 1
fi

if [[ ! -f "$public_key_source" ]]; then
    echo "Error: Public key not found at $public_key_source"
    exit 1
fi

# Create local copies instead of symlinks
cp "$private_key_source" "$project_private_key"
cp "$public_key_source" "$project_public_key"

# Restrict permissions
chmod 600 "$project_private_key"
chmod 644 "$project_public_key"

# Install dependencies
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install -y ansible python3-click

echo "Done."