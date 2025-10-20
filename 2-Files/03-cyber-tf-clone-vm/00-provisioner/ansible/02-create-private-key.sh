#!/bin/bash
# Create private key
ssh-keygen -t rsa -b 4096 -f /home/administrator/.ssh/id_rsa -N ""
cat /home/administrator/.ssh/id_rsa.pub >> /home/administrator/.ssh/authorized_keys
chmod 600 /home/administrator/.ssh/authorized_keys
chmod 600 /home/administrator/.ssh/id_rsa
chmod 644 /home/administrator/.ssh/id_rsa.pub
