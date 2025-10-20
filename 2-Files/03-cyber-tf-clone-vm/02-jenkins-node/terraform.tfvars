## Common VMware vsphere parameters
vsphere_user     = "surat.j@vsphere.local"
vsphere_password = "P@$$w0rd!@#$%"
vsphere_server   = "172.27.10.230"
datacenter       = "Datacenter" #ใน vCenter, คุณสามารถดูค่า Datacenter ได้ที่เมนู "Hosts and Clusters" ซึ่งจะเป็นชื่อของ Datacenter ที่แสดงอยู่ใน Tree View ทางซ้ายมือใต้ vCenter
cluster          = "Your-Cluster-Name"
network          = "Cyber-Server" # vLAN-55,vLAN-140,vLAN-150
guest_id         = "ubuntu64Guest"
adapter_type     = "vmxnet3"
pool_dats_tf_1   = "Veeam-DR-Test"
pool_dats_tf_2   = "DATS-TF-2"
pool_dats_tf_3   = "DATS-TF-3"
datastore_lun01  = "LUN01"
datastore_lun02  = "LUN02"
datastore_lun03  = "LUN03"

# Common variable
base_vm_name = "infra-lab"
vm_gateway_ip = "172.27.10.254"

# Rancher control
vm_rancher_name                 = "jenkins"
vm_rancher_description          = "jenkins for Dev CICD"
vm_rancher_num_vcpus_per_socket = 4 #vcpu
vm_rancher_num_sockets          = 1
vm_rancher_memory_size_mib      = 8192 # 8GB
vm_rancher_cloud_init_user_data = ""
vm_rancher_disk_size_gb         = 50 # 50GB, Example size in GiB, adjust as needed
vm_rancher_ip                   = "172.27.10.94"