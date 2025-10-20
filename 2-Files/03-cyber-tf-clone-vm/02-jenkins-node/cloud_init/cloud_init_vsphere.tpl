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
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDPce090Y8TdWk/0wOG4SvQpAkimxmFUFftTPW+NzNFcqfBNMdElgyf81RqBKqKnSbc4Ca56Zqc3GvVhhN8tpegEvqhqpvPgPr8O2KmlMcFu+rruWi3hXyIVJd5KBMjfokGMuR3IY0WYHnbPb5xlqZKAP5tWzqlT5Wpr+pRUG3aia5nLHxg6qSQrxKAMzXt7S2r8uzO1xHzhssB0JDw0Xmh2P+Pk79GvYsXh6w4r46eUTt1qOeATVuennTH4tWGyEYpBWJmd/UK4ZmV8cepkhs53rhYHw5DmUkgfgyX9B1sf7N/6uHOYcfkNI5iusM2yYNSYxeysOo6pXOkgmAyePwlTuvCHDgExvIB/KuA2+/0EJwGtPqa4pyMNfX0nf/2tHGFJDdEBfogX6liYjOtIbvVHRQVybt5JZBVkzGISU8V2XJES7WTL0BZeambT8+LoVXh487zgy3sO5IsUuB24WKsJn6vFwgsDLSrQCgtf0fst0qPGFoW+TGIZ8vY63oP5LE= rvconnex\thawatchai.s@DAT-TWCS
  
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
- apt-get install -y docker.io
- curl -L "https://github.com/docker/compose/releases/download/v2.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
- chmod +x /usr/local/bin/docker-compose
- usermod -aG docker $USER
- ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
- systemctl start docker.service
- systemctl enable docker.service
- systemctl enable containerd.service