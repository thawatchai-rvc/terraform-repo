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
  default     = "./cloud_init/cloud_init_vsphere.tpl"
}

variable "vm_gateway_ip" {
  description = "Static IP addresses for gateway"
  type        = string
}

# Rancher control for CI/CD cluster
variable "vm_rancher_name" {}
variable "vm_rancher_description" {}
variable "vm_rancher_num_vcpus_per_socket" {}
variable "vm_rancher_num_sockets" {}
variable "vm_rancher_memory_size_mib" {}
variable "vm_rancher_cloud_init_user_data" {}
variable "vm_rancher_disk_size_gb" {}
variable "vm_rancher_ip" {}

# Master VM variables for CI/CD cluster
variable "vm_cicd_master_count" {}
variable "vm_cicd_master_name" {}
variable "vm_cicd_master_description" {}
variable "vm_cicd_master_num_vcpus_per_socket" {}
variable "vm_cicd_master_num_sockets" {}
variable "vm_cicd_master_memory_size_mib" {}
variable "vm_cicd_master_static_ips" {
  description = "List of static IP addresses for the VMs"
  type        = list(string)
}
variable "vm_cicd_master_disk_size_gb" {}

# Node VM variables for CI/CD cluster
variable "vm_cicd_node_count" {}
variable "vm_cicd_node_name" {}
variable "vm_cicd_node_description" {}
variable "vm_cicd_node_num_vcpus_per_socket" {}
variable "vm_cicd_node_num_sockets" {}
variable "vm_cicd_node_memory_size_mib" {}
variable "vm_cicd_node_static_ips" {
  description = "List of static IP addresses for the VMs"
  type        = list(string)
}
variable "vm_cicd_node_disk_size_gb" {}