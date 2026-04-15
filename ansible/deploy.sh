#!/usr/bin/env bash

# Exit immediately if a command fails
set -e

# Check if hostname argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <hostname>"
    exit 1
fi

# Store the hostname argument
target_hostname="$1"

# Define inventory file and playbook
inventory_file="inventory.yml"
playbook_file="site.yml"

# Run ansible-playbook with limit to the given hostname
ansible-playbook -i "$inventory_file" "$playbook_file" --limit "$target_hostname"