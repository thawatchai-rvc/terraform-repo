### Connect to vCenter ###
vsphere_user     = "administrator@lab.local"
vsphere_password = "P@ssw0rd" 
vsphere_server   = "vcenter.lab.local"

### Setting vCenter Environment ###
datacenter       = "Datacenter"
cluster          = "New Cluster"
pool_vms_1       = "Node-1-Resource-Pool"
network          = "VM Network"
# datastore        = "local-ds-esxi-01"
datastore        = "vsanDatastore (1)"

### Configuration to VMs ###
vm_count      = 2
# vm_ips       = ["10.1.3.17"]
vm_ips       = ["10.1.3.18", "10.1.3.19"]
gateway       = "10.1.3.1"
vm_name_prefix = "Terraform-cloud-master-vm"
