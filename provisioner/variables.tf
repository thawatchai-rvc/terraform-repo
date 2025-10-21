## VMware vsphere
variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "datacenter" {}
variable "cluster" {}
variable "network" {}
variable "adapter_type" {}
variable "guest_id" {}
variable "pool_dats_tf_1" {}
variable "pool_dats_tf_2" {}
variable "pool_dats_tf_3" {}
variable "datastore_lun01" {}
variable "datastore_lun02" {}
variable "datastore_lun03" {}

# Common variable
variable "base_vm_name" {}
variable "cloud_init_file_path" {
  description = "Path to the cloud-init configuration file"
  type        = string
  default     = "./cloud_init/cloud_init_provisioner.tpl"
}
variable "vm_gateway_ip" {
  description = "Static IP addresses for gateway"
  type        = string
}

# Provisioner
variable "vm_provisioner_name" {}
variable "vm_provisioner_description" {}
variable "vm_provisioner_num_vcpus_per_socket" {}
variable "vm_provisioner_num_sockets" {}
variable "vm_provisioner_memory_size_mib" {}
variable "vm_provisioner_cloud_init_user_data" {
  description = "Cloud Init user data"
  type        = string
}
variable "vm_provisioner_disk_size_gb" {}
variable "vm_provisioner_hostname" {
  description = "Hostname of the VM"
  type        = string
}
variable "vm_provisioner_ip" {
  description = "Static IP address of the VM"
  type        = string
}