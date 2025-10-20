#!/bin/bash
# Install Ansible
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt update
sudo apt install -y ansible
ansible --version