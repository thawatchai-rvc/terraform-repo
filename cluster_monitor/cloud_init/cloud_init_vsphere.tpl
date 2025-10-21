#cloud-config
package_update: true
package_upgrade: true

users:
  - name: administrator
    gecos: Administrator User
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin
    home: /home/administrator
    shell: /bin/bash
    lock_passwd: false
    passwd: "$6$Gap1BxMQiONpN/Vx$GmgBcXTPbngaCvZb74iff94ZKTd89qH41YZDF3bR6iX0rfSfPerDpuuHd.aI9aeAlVV5VkwQYWxkk0IXYgsHs1"
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNcMQX0WBPW6vf9+TvbFNF+y0vs0/si1SJjZQpR6RCqFL12mwfkUT0tr9R8Cklnwweka2H3XfRsh5EjJkjufIdZmPC5HPbHcyDT9U1vpX/zsggi6IVGKpEbXzAU5/VlTiStHQqm9NWuiJlLTF9RScYaCx8uqGFMuf/UG0Qbh0ZW0bLtzXGRnvLyGbaRoMhWQCD9u3ZXPFKtZxN3W4jUJBlOtS5PVWm68ixUMC6xeLd2XQZ1M+M672BRPzOqd0f5tCq412a1cdFx+BtCN8XqDfaQIUVJyr9IgFMbvJad5Kjd6hSiSPzvZwXGZtYb6V+XTGQdSfUCQS3YgWCeMwD78c/cGJb7FLCHINTL3SYcgejhX1At/7EkDC8LWeeabCyLBFPCrIlcGwJkm4mHPuXgOIJALfjZR2nwtAf6thMlFjg7WhevsioBkjFY1yXNjgFSepRAGoA/BKacgyP9iQnCaIilOzgO6gXHZgEc5g+7/xbC4FzMaCWq2VhiNG65kgM2YXKrtADhcAHw3ad9tvwS9+YmlXvwg6X9JrQHriAoTzpD9rRll3CWbKyKj4MiCgjcxvr/QMtlEfxUH29WLGSIX5FErCA7noQ3f0QHj/8TYbaKZKcJwBfL3EOFSWQSOeshL9rkAbQ2YZW0FbtMZk9Ox3ByvLKGIbP8tQ+LxJDceqi1Q== administrator@ubuntu24-remote

ssh_pwauth: true
chpasswd:
  expire: false

hostname: ${hostname}
manage_etc_hosts: true

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
            addresses: [192.168.140.251, 8.8.8.8]

packages:
- docker.io
- curl

runcmd:
- netplan apply
- apt-get update
- apt install net-tools
- apt-get install -y docker.io
- curl -L "https://github.com/docker/compose/releases/download/v2.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
- chmod +x /usr/local/bin/docker-compose
- usermod -aG docker $USER
- ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
- systemctl start docker.service
- systemctl enable docker.service
- systemctl enable containerd.service
