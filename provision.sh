#!/usr/bin/env bash
#
# This script is a Distrobox init hook. It ensures Ansible is installed
# and the configuration directory has the correct user ownership.

# --- Installation (only runs if Ansible is not found) ---
if ! command -v ansible &> /dev/null; then
    echo "Ansible not found. Beginning one-time installation..."

    # Install prerequisites using the official PPA
    sudo apt-get update
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt-get install -y ansible

    echo "Ansible installation complete."
else
    echo "Ansible already installed."
fi

# --- Ownership Correction (runs every time) ---
# This is the critical step.
# If the ~/.ansible directory exists and is owned by root,
# change its ownership to the current user.
# This is safe to run every time and fixes the permission error.
if [ -d "$HOME/.ansible" ] && [ "$(stat -c '%U' "$HOME/.ansible")" = "root" ]; then
    echo "Correcting ownership of $HOME/.ansible..."
    # Use $USER to avoid hardcoding your username.
    sudo chown -R "$USER":"$USER" "$HOME/.ansible"
fi

# --- Verification ---
echo "Verifying Ansible installation and permissions..."
ansible --version

echo "Ansible provisioning complete."