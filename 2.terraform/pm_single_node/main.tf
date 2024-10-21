provider "proxmox" {
    pm_api_url = "https://192.168.31.201:8006/api2/json"
    pm_api_token_id = "root@pam!root_token"
    pm_api_token_secret = "f45c9554-18d5-47d8-835b-5fe5dbf3127d"
    pm_tls_insecure = true

    # Раскомментировать для дебага.
    # pm_log_enable = true
    # pm_log_file = "terraform-plugin-proxmox.log"
    # pm_debug = true
    # pm_log_levels = {
    # _default = "debug"
    # _capturelog = ""
    # }
}


resource "proxmox_vm_qemu" "virtual_machines" {
    for_each = var.virtual_machines

    name = each.value.hostname
    target_node = each.value.target_node
    clone = each.value.vm_template
    # Activate QEMU agent for this VM
    agent = "1"

    # Start on boot
    onboot      = true
    vmid = each.value.vmid
    ciuser = each.value.ciuser
    cipassword = each.value.cipassword
    os_type = "cloud-init"
    cloudinit_cdrom_storage = "local-lvm"
    cores = each.value.cpu_cores
    sockets = each.value.cpu_sockets
    cpu = "host"
    memory = each.value.memory
    scsihw = "virtio-scsi-pci"
    bootdisk = "scsi0"

   disks {
       scsi {
           scsi0 {
               disk {
                 storage = "VM-SSD"
                 size = each.value.hdd_size
                    }
                }
           }
        }

    network {
        model = "virtio"
        bridge = "vmbr0"
#           tag = each.value.vlan_tag
    }

    # Not sure exactly what this is for. something about 
    # ignoring network changes during the life of the VM.
    lifecycle {
        ignore_changes = [
        network,
        ]
    }

    # Cloud-init config
    ipconfig0 = "ip=${each.value.ip_address},gw=${each.value.gateway}"
    nameserver = "192.168.31.2"
    sshkeys = var.ssh_key
}

output "vm_ipv4_addresses" {
  value = {
      for instance in proxmox_vm_qemu.virtual_machines:
      instance.name => instance.default_ipv4_address
  }
}
