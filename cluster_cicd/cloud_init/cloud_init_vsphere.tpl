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
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMljjEHHb3FeCUBui1OHdZeRoa9C4N0RQsVFuHD19ttv6hfCJECEzOGgF9TWEf/cXO2SvyHEQIUILiMPEVcV0Doo8UFdApMdw8a+uye+oaNlNFZW5vJOnAi19bZhUAhT46dXDU7YgbTNmZ/EZQum6Ndkm9ufggzQO65+OgIqHFCn+AdtE5U+rA6+ENn0V+EUD9Z+85D7fmXVoDhubzRY26lokNAC/VACaSb5F0+ker/VxV9kBTZprP/CGzAfSKoydEks3HFu8bWEaEL6DZjS9TP7Hj92JlLS4wFoloRTl4BvJ1WauyNsDoV1bH8jOGsMgvVtc6bAkWKlAbHj+l0tmjGlwb1JZrKpe6qHVKw3SzvIgN9ndUzuCb+4YSMTFcI32IIIFXJ5TYo2J2r3yjVXQUZnmo7oL3WXu/z5c68/H7TFnn57zk4pu3UkdCQA46c8CT65BRIEDlPr7JrCaEVxk/4F+mSxs/GOxMbW/+8w7K3GYEpj3ncj0L1QPpwl8ydAM= administrator@RVCIDMC001.local
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCZ7IV3bQHIIaVof6VRaxcw4WGsMUSK4J0C8CDVsLGqg2+Yp9ZZsYdCc7IDLFz1mVnBV94YTrtF9zl22E0Gg0wsT3/44ZrR1LUHCj5YNn2KfJwmNLbgRbiw+mrr3LNnsVsSEzyvHCeNPPFkzFtVniIONxDSejtuOtTbAys0fF0psCtG8bFBg50BX2akkF/DzezxBpkGWFk7jSnucxfKEms+K6qR2k8XmawIbTMVto3evnbjDjThgj/dKeJKWpSHTUTAYcSGze9hYRhunprY2WC1IUkzaadgMCzSwSe9/CZz0/ahXbx+ZlZPgCoaePvgay30DYBjH0X/u+XTZRy5qzqhQt+MtM6b65Yo47keaxGHUCdfFQr6ChSTCGVfkKBkxwuiC03LxyDx8ARTjzn1VMZMF0e5i/sv46NzhV84tORT2Q+uorgIYWBn3QDqECqXf/xWioz7pIc7k2B1ss2paVfBthOsiPkYNWjUKO73QSvPtoJJkfFPCWxFHfxdv73bRh/bRKQRBQik7BcOjB2DkVL2FK1x3VcWsZmpjEVpGKTNie5vmrEZRTJARxZlGE/A9l7DCEwDX+wehon2p8JsM43vMAmNQ10UXfBlQ8tz5x3uSUt2ufgT+f0I0VhM1gl4Tc2Y54XWDpGZO6v3p11lOa1B0uOrXBby+zlf8fQygmax2Q== root@d2s-failover-provisioner
  
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
            addresses: [192.168.140.251, 1.1.1.1, 8.8.8.8]

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