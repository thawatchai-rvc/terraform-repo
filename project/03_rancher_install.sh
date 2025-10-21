# Dev site
# ansible-playbook -i inventory/development/hosts-dev playbooks/rancher/00_common.yaml
# ansible-playbook -i inventory/development/hosts-dev playbooks/rancher/01_rancher_install.yaml
# ansible-playbook -i inventory/development/hosts-dev playbooks/rancher/02_rancher_change_password.yaml
# ansible-playbook -i inventory/development/hosts-dev playbooks/rancher/03_create_cicd_cluster.yaml
# ansible-playbook -i inventory/development/hosts-dev playbooks/rancher/04_create_database_cluster.yaml
# ansible-playbook -i inventory/development/hosts-dev playbooks/rancher/11_delete_fraud_cluster.yaml
# ansible-playbook -i inventory/development/hosts-dev playbooks/rancher/05_create_fraud_cluster.yaml
# ansible-playbook -i inventory/development/hosts-dev playbooks/rancher/06_create_dev_cluster.yaml
# ansible-playbook -i inventory/development/hosts-dev playbooks/rancher/07_create_sit_cluster.yaml
ansible-playbook -i inventory/development/hosts-dev playbooks/rancher/08_get_all_kubeconfig.yaml
ansible-playbook -i inventory/development/hosts-dev playbooks/rancher/09_install_longhorn.yaml
ansible-playbook -i inventory/development/hosts-dev playbooks/rancher/10_install_argocd.yaml
ansible-playbook -i inventory/development/hosts-dev playbooks/rancher/12_set_coredns.yaml