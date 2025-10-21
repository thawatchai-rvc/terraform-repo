# Set timezone and configure time sync
# Dev site
# ansible-playbook -i inventory/development/hosts-dev playbooks/timesync/01_time_sync.yaml --check
ansible-playbook -i inventory/development/hosts-dev playbooks/timesync/01_time_sync.yaml
