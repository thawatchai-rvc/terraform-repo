# test-ping, set-timesync
ansible-playbook -i inventory/hosts --ssh-extra-args="-o StrictHostKeyChecking=no" playbooks/01-ping-check.yaml
# ansible-playbook -i inventory/hosts --ssh-extra-args="-o StrictHostKeyChecking=no" playbooks/02-time-sync.yaml
# ansible-playbook -i inventory/hosts --extra-vars "ansible_become_password=P@ssw0rd" --ssh-extra-args="-o StrictHostKeyChecking=no" playbooks/02-time-sync.yaml

# install-rancher
# ansible-playbook -i inventory/hosts --ssh-extra-args="-o StrictHostKeyChecking=no" playbooks/rancher/00_common.yaml
# ansible-playbook -i inventory/hosts --ssh-extra-args="-o StrictHostKeyChecking=no" playbooks/rancher/01_rancher_install.yaml
# ansible-playbook -i inventory/hosts --ssh-extra-args="-o StrictHostKeyChecking=no" playbooks/rancher/02_rancher_change_password.yaml
# ansible-playbook -i inventory/hosts --ssh-extra-args="-o StrictHostKeyChecking=no" playbooks/rancher/03_create_lab_cluster.yaml

# create-cluster
# ansible-playbook -i inventory/hosts --ssh-extra-args="-o StrictHostKeyChecking=no" playbooks/rancher/03_create_lab_cluster.yaml

# install-tool-to-cluster
# ansible-playbook -i inventory/hosts --ssh-extra-args="-o StrictHostKeyChecking=no" playbooks/rancher/08_get_all_kubeconfig.yaml
# ansible-playbook -i inventory/hosts --ssh-extra-args="-o StrictHostKeyChecking=no" playbooks/rancher/09_install_longhorn.yaml