
variable "vsphere_user" {
  type = string
}

variable "vsphere_password" {
  type = string
}

variable "vsphere_server" {
  type = string
}

variable "datacenter" {
  type = string
}

variable "cluster" {
  type = string
}

variable "pool_vms_1" {
  type = string
}

variable "network" {
  type = string
}

variable "datastore" {
  type = string
}

variable "vm_count" {
  type = string
  description = "จำนวน VM ที่ต้องการสร้าง"
  # default     = 1
}

variable "vm_ips" {
  type        = list(string)
  description = "IP เริ่มต้นสำหรับ VM"
  }

variable "gateway" {
  type = string
  description = "Gateway IP Address"
  # default     = "10.1.3.1"
}

variable "vm_name_prefix" {
  type = string
  description = "Prefix สำหรับชื่อ VM"
  # default     = "ubuntu-cloud-vm"
}
