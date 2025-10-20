variable "vm_count" {
  description = "จำนวน VM ที่ต้องการสร้าง"
  default     = 1
}

variable "vm_ips" {
  description = "IP เริ่มต้นสำหรับ VM"
#   type        = list(string)
}

variable "gateway" {
  description = "Gateway IP Address"
  default     = "10.1.3.1"
}

variable "vm_name_prefix" {
  description = "Prefix สำหรับชื่อ VM"
  default     = "ubuntu-cloud-vm"
}
