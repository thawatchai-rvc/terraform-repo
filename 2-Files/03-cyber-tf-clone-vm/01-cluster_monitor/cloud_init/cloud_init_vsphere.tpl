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
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCq95ySsLg+Q0NPkSZXeZpG4NCv7RwR9yrLQow1+/Mx0kFtNJNlwlRCsEZ3iOt8V26KKxS4z/TlEYMSdh4WJNNdktSzlnONmDFQ+zAzQCJh+bXdE/rxnN9Y5lOtFix2xx4vXSSdbUximad9axLCdQLcjhCvimG0+PnSCs/YnJT7t/5LBXd3l6uJb55KVb5clM0ixoIM3aFTQD7uckjm/FO4DEm+o+d7RjQz0cxdmIOfr0dZp2Qs9cqL/muSS3S0ag2jET+BWrH12OUatcDTTkEClMSJfh+XJJtGG7Xrtyci2fqymMmZ7f/NKv6371G08VaGzDOHXY7Ppw9/uJ7QszhTRVdHc9I0fS77sM6VWxyQcJCV8wXwvi+8lSyRgbnIn+aXByoHkFOc8JA1kt3ma9hMOo4/MZSNe/P6EqE9PYoS+j2pSaHKQfQLXyXdo6QL4NfC4U9dvtG0YtmszrtpVtYKKHhGSZ+SkWQDrtvWwMTs9BOjYy9/kKV2401X13J8L3Fc02XOaGudyE4YeZ1w1S1TVfZiTqo28XaYuJ2o/ZlM9QscscV3CPDtxIw0mU0vERsIXGxIEkIqHpDVvTJA5f17WV0jmRXlb7TF1DQWJqL6lk4de5p7t7lkstExWh0xFJpMpT/InqAYeOubIjEsINUwd+jGbmWNe5pakodYipBrHw== root@infra-lab-provisioner
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDcE8JJUE5govt1+QcqsqArHAE5OenjaMSvr04AmgJ8DSrKg1BJ47UZLsTfacWne5N7FFBPH6R8GQrmeMQwus6IZo8WtRl/2tc6hICsgZG/i7cPFfGNB+L44gVu6DbsFiTzSk9Mu67VztDW97feSw70wup0iPHp3toZZ5RSnYPTrSlYGezMp4p32CbHuO7nZClD4RiY+QQVckoy0ttjkkEcEVhZucLiYksoSpAezyr/DxAa767WY5to4Gu7xkYMB3ZUrABQw1AV9Of3Kt08NMQOdi8gcADCc6unnIbVWQbaBpMHOXRrtefnTKkwQ7LjDdkS3xsTIcnkFfxu4Kfdh4HD4AIklA2W1W5FhI8sD8SasoNDXczCJ0uK650LpK/PN1m+yMIOKz7AydOD+OOAXswzXgUVmxLFQVtrkKWQJeW2GLojfMwTpIykBtZcafciWPhVxawMONsT7smkOdkDnRI5vFHSkhyuPd7haV+kTamH5llMHAiQd4Zobp79jB+kcOk= rvconnex\thawatchai.s@DAT-TWCS

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
