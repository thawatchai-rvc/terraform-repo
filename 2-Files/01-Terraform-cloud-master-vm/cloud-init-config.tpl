#cloud-config

# sets the hostname to 'terraformed'
hostname: ${hostname}

users:
  # Adds a user called 'example' with the password hash of 'passwort', sudo rights and the default ubuntu groups
  - name: administrator
    gecos: Administrator User
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin
    home: /home/administrator
    shell: /bin/bash
    lock_passwd: false
    #plain_text_passwd: ""  # Unused
    passwd: "$2y$10$/Qy//GnIhWuGKKckKCHn8Ox4pP/ezV3WxVKVgXLKnky8vLXtdWd5e" # รหัสผ่านแบบ Hash
    # ssh_authorized_keys:
    #   - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMljjEHHb3FeCUBui1OHdZeRoa9C4N0RQsVFuHD19ttv6hfCJECEzOGgF9TWEf/cXO2SvyHEQIUILiMPEVcV0Doo8UFdApMdw8a+uye+oaNlNFZW5vJOnAi19bZhUAhT46dXDU7YgbTNmZ/EZQum6Ndkm9ufggzQO65+OgIqHFCn+AdtE5U+rA6+ENn0V+EUD9Z+85D7fmXVoDhubzRY26lokNAC/VACaSb5F0+ker/VxV9kBTZprP/CGzAfSKoydEks3HFu8bWEaEL6DZjS9TP7Hj92JlLS4wFoloRTl4BvJ1WauyNsDoV1bH8jOGsMgvVtc6bAkWKlAbHj+l0tmjGlwb1JZrKpe6qHVKw3SzvIgN9ndUzuCb+4YSMTFcI32IIIFXJ5TYo2J2r3yjVXQUZnmo7oL3WXu/z5c68/H7TFnn57zk4pu3UkdCQA46c8CT65BRIEDlPr7JrCaEVxk/4F+mSxs/GOxMbW/+8w7K3GYEpj3ncj0L1QPpwl8ydAM= administrator@RVCIDMC001.local

ssh_pwauth: true
chpasswd:
  expire: false

packages:
  - gnupg
  - software-properties-common
  - curl

write_files:
- path: /etc/netplan/50-cloud-init.yaml
  content: |
    network:
      version: 2
      ethernets:
        ens192:
          dhcp4: no
          addresses:
            - ${ip_address}/24
          gateway4: ${gateway}
          nameservers:
            addresses: [8.8.8.8,8.8.4.4]

runcmd:
  - netplan apply
  - apt-get update
#   # Install Terrafrom
#   # - apt-get install -y gnupg software-properties-common
#   - wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
#   - gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
#   - echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
#   - apt-get update
#   - apt-get install -y terraform
#   # Install Ansible
#   - apt-add-repository --yes --update ppa:ansible/ansible
#   - apt-get update
#   - apt-get install -y ansible
#   # Create private key
#   - ssh-keygen -t rsa -b 4096 -f /home/administrator/.ssh/id_rsa -N ""
#   - cat /home/administrator/.ssh/id_rsa.pub >> /home/administrator/.ssh/authorized_keys
#   - chmod 600 /home/administrator/.ssh/authorized_keys
#   - chmod 600 /home/administrator/.ssh/id_rsa
#   - chmod 644 /home/administrator/.ssh/id_rsa.pub

