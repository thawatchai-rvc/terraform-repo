## Common VMware vsphere parameters
vsphere_user     = "surat.j@vsphere.local"
vsphere_password = "P@$$w0rd!@#$%"
vsphere_server   = "172.27.10.230"
datacenter       = "Datacenter" #ใน vCenter, คุณสามารถดูค่า Datacenter ได้ที่เมนู "Hosts and Clusters" ซึ่งจะเป็นชื่อของ Datacenter ที่แสดงอยู่ใน Tree View ทางซ้ายมือใต้ vCenter
cluster          = "Your-Cluster-Name"
network          = "Cyber-Server" # vLAN-55,vLAN-140,vLAN-150
guest_id         = "ubuntu64Guest"
adapter_type     = "vmxnet3"
pool_dats_tf_1   = "Infra-lab"
pool_dats_tf_2   = "DATS-TF-2"
pool_dats_tf_3   = "DATS-TF-3"
datastore_lun01  = "LUN01"
datastore_lun02  = "LUN02"
datastore_lun03  = "LUN03"

# Common variable
base_vm_name = "d2s-failover"

# Provisioner
vm_provisioner_name                 = "provisioner"
vm_provisioner_description          = "Provisioner management"
vm_provisioner_num_vcpus_per_socket = 2 #vcpu
vm_provisioner_num_sockets          = 1
vm_provisioner_memory_size_mib      = 4096 # 4GB
vm_provisioner_cloud_init_user_data = ""
vm_provisioner_disk_size_gb        = 50 # 50GB, Example size in GiB, adjust as needed
vm_provisioner_hostname             = "provisioner"
vm_provisioner_ip                   = "172.27.10.99"
vm_gateway_ip                       = "172.27.10.254"