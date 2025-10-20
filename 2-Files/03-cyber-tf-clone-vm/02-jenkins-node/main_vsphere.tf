provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

# data "vsphere_compute_cluster" "cluster" {
#   name          = var.cluster
#   datacenter_id = data.vsphere_datacenter.dc.id
# }

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool_dats_tf_1" {
  name          = var.pool_dats_tf_1
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool_dats_tf_2" {
  name          = var.pool_dats_tf_2
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool_dats_tf_3" {
  name          = var.pool_dats_tf_3
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore_lun01" {
  name          = var.datastore_lun01
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore_lun02" {
  name          = var.datastore_lun02
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore_lun03" {
  name          = var.datastore_lun03
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "ubuntu-24.04-server-cloudimg-amd64" # ระบุชื่อ VM หรือ Template ที่ต้องการโคลน
  datacenter_id = data.vsphere_datacenter.dc.id
}

#########################
resource "vsphere_virtual_machine" "infra-lab-cicd-dev-rancher" {
  # General Information
  name             = "${var.base_vm_name}-${var.vm_rancher_name}"
  resource_pool_id = data.vsphere_resource_pool.pool_dats_tf_1.id 

  num_cpus = var.vm_rancher_num_vcpus_per_socket
  memory   = var.vm_rancher_memory_size_mib
  guest_id = var.guest_id # ใช้ guest_id สำหรับ Ubuntu 64-bit

  disk {
    label            = "disk0"
    size             = var.vm_rancher_disk_size_gb
    eagerly_scrub    = false
    datastore_id     = data.vsphere_datastore.datastore_lun01.id # อย่าลืมไปแก้ที่ General Information
    thin_provisioned = true
  }

  cdrom {
    client_device = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = var.adapter_type
  }
  wait_for_guest_net_timeout = 0 # ปิดการรอ IP address

  vapp {
    properties = {
      "user-data" = base64encode(templatefile(var.cloud_init_file_path, {
        hostname   = "${var.base_vm_name}-${var.vm_rancher_name}",
        ip_address = var.vm_rancher_ip,
        gateway    = var.vm_gateway_ip
      }))
    }
  }
}

