provider "vsphere" {
  user           = var.vsphere_user     # ชื่อผู้ใช้ vSphere/ESXi
  password       = var.vsphere_password      # รหัสผ่าน
  vsphere_server = var.vsphere_server    # IP หรือ FQDN ของ vCenter/ESXi
  allow_unverified_ssl = true           # หากใช้ Self-Signed Certificate
}

# กำหนด Datacenter
data "vsphere_datacenter" "dc" {
  name = var.datacenter                 # ชื่อ Datacenter ใน vCenter
}

# กำหนด Cluster
data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster      # ชื่อ Cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

# กำหนด Pool
data "vsphere_resource_pool" "pool" {
  name          = var.pool_vms_1
  datacenter_id = data.vsphere_datacenter.dc.id
}

# กำหนด Network
data "vsphere_network" "network" {
  name          = var.network        # ชื่อ Network ใน vCenter
  datacenter_id = data.vsphere_datacenter.dc.id
}

# กำหนด Datastore
data "vsphere_datastore" "datastore" {
  name          = var.datastore        # ชื่อ Datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "ubuntu-noble-24.04-cloudimg" # ระบุชื่อ VM หรือ Template ที่ต้องการโคลน
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  count            = var.vm_count
  name             = "${var.vm_name_prefix}-${count.index + 1}" # รันเลขชื่อ VM
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id # ใช้ cluster
  # resource_pool_id = data.vsphere_resource_pool.pool.id # ใช้ resource pool 
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 4096  # 2GB= 2048 4GB= 4096
  guest_id = "ubuntu64Guest" # ใช้ guest_id สำหรับ Ubuntu 64-bit
  

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }
  
  wait_for_guest_net_timeout = 0 # ปิดการรอ IP address

  disk {
    label            = "disk0"
    size             = 20
    eagerly_scrub    = false
    datastore_id     = data.vsphere_datastore.datastore.id
    thin_provisioned = true
  }

  cdrom {
    client_device = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

vapp {
    properties = {
      "user-data" = base64encode(templatefile("./cloud-init-config.tpl", {
        hostname   = "${var.vm_name_prefix}-${count.index + 1}",
        ip_address = var.vm_ips[count.index],
        gateway    = var.gateway
      }))
    }
  }

  # Can run script 
  # vapp {
  #   properties = {
  #     user-data = base64encode(file("./cloud-init-config.tpl"))
  #   }
  # }

}
