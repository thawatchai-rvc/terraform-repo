## Dev site
# ansible -i inventory/development/hosts-dev --ssh-extra-args="-o StrictHostKeyChecking=no" spider-cicd-dev-rancher -m ping
# ansible -i inventory/development/hosts-dev --ssh-extra-args="-o StrictHostKeyChecking=no" spider-cicd-dev -m ping
# ansible -i inventory/development/hosts-dev --ssh-extra-args="-o StrictHostKeyChecking=no" spider-fraud-dev -m ping
# ansible -i inventory/development/hosts-dev --ssh-extra-args="-o StrictHostKeyChecking=no" spider-lb-dev -m ping
# ansible -i inventory/development/hosts-dev --ssh-extra-args="-o StrictHostKeyChecking=no" spider-db-dev -m ping
# ansible -i inventory/development/hosts-dev --ssh-extra-args="-o StrictHostKeyChecking=no" spider-dev-dev -m ping
# ansible -i inventory/development/hosts-dev --ssh-extra-args="-o StrictHostKeyChecking=no" spider-sit-dev -m ping



ansible-playbook -i inventory/development/hosts-dev --ssh-extra-args="-o StrictHostKeyChecking=no" playbooks/timesync/ping_check.yml
