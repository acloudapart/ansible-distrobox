#!/usr/bin/env bash

# Install prerequisites
sudo apt-get update
sudo apt-get install -y software-properties-common

# Add the Ansible PPA
sudo add-apt-repository --yes --update ppa:ansible/ansible

# Install Ansible
sudo apt-get install -y ansible

# Verify installation
ansible --version