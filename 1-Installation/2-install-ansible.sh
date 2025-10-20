#!/bin/bash
# ============================================================
# Script: install_ansible.sh
# Description: Auto install Ansible on Ubuntu 24.04 (Noble)
# Author: RV Connex Infrastructure Team
# Tested on: Ubuntu 24.04 LTS
# ============================================================

set -e

echo "------------------------------------------------------------"
echo "   🔧 Installing Ansible on Ubuntu 24.04 (Noble Numbat)"
echo "------------------------------------------------------------"
sleep 1

# Update system
echo "[1/6] Updating package list..."
sudo apt update -y

# Install prerequisites
echo "[2/6] Installing prerequisites..."
sudo apt install -y software-properties-common curl git python3 python3-pip

# Add official Ansible PPA
echo "[3/6] Adding official Ansible repository..."
sudo add-apt-repository --yes --update ppa:ansible/ansible

# Install Ansible
echo "[4/6] Installing Ansible..."
sudo apt install -y ansible

# Optional: Install common Ansible collections
echo "[5/6] Installing Ansible Galaxy base collections..."
ansible-galaxy collection install ansible.posix community.general

# Check version
echo "[6/6] Verifying Ansible installation..."
ansible --version

echo "------------------------------------------------------------"
echo "✅ Ansible installation completed successfully!"
echo "------------------------------------------------------------"

# Optional hint
echo "You can now test your installation with:"
echo "  ansible localhost -m ping"
