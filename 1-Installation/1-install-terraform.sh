#!/bin/bash

# Terraform Installation Script for Ubuntu

# Update and upgrade the system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Install prerequisites
echo "Installing prerequisites..."
sudo apt install -y software-properties-common gnupg

# Add HashiCorp GPG Key
echo "Adding HashiCorp GPG key..."
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add HashiCorp repository
echo "Adding HashiCorp repository..."
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update and install Terraform
echo "Updating package list and installing Terraform..."
sudo apt update
sudo apt install terraform -y

# Verify installation
echo "Verifying Terraform installation..."
terraform -version

echo "Terraform installation completed!"
