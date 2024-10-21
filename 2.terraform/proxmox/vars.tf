

variable "ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCooAlDKM4p1JjhtyKhfii2kKDLidLB+mJhDHIFtLZBbYqOPxi+9EdEwYLuZuA7j+6w6UzklpM8bmssJRJHzDwHdDgj9LGNFzyeoRvAhU+AcjrrtyELC+a9n0LliHummWH64t5OewbxonF6TiHtY5U3wUUIYtHmJcTqNmQvSxXiN15ay/d1N4d39L4ut9NImzMYHEOF0rsm+C3FdlB5Fkzsiry1yJBKAnRfKiYdLkI4Y+FRGJRAowV/UlZeqFhhSYVCiRGH+N2kAxlczOoT5Y4RBjJE0+rPRD+Xct2JSlaZXOt6A9Uma66nSsYDR7JkeoTllnTxMDPuqJaPx+872GLvL0zlvsxWz5rD5KnQk8B8QtJjHpzuAkvm0NXLrUOS8UhIacLFl6YOaLBdTYu9uEBol3J9Q6cZpWuk/JcURvwwc+sNUPn6TDNmbTCxgCz7bUp9MsUhjhw9TZ/U+63JegQQ3lOkGlewHc7YC/Ldh2DdYBxCmTrvDXTTML1z1xIdSyc= ioc0@T1-024-1569.local"
}

variable "virtual_machines" {
    default = {
        "master-test-01" = {
            hostname = "server"
            ip_address = "192.168.31.30/24"
            gateway = "192.168.31.1",
#            vlan_tag = 100,
            target_node = "proxmox",
            cpu_cores = 2,
            cpu_sockets = 2,
            memory = "8192",
            hdd_size = 40,
            vm_template = "ubuntu-2204-cloud",
            vmid = "300",
            ciuser = "ioc0",
            cipassword = "Depe8958",

        },
        "worker-test-02" = {
            hostname = "node0"
            ip_address = "192.168.31.31/24"
            gateway = "192.168.31.1",
#            vlan_tag = 100,
            target_node = "proxmox",
            cpu_cores = 2,
            cpu_sockets = 2,
            memory = "8192",
            hdd_size = 40,
            vm_template = "ubuntu-2204-cloud",
            vmid = "301",
            ciuser = "ioc0",
            cipassword = "Depe8958",
        },
        "worker-test-03" = {
            hostname = "node1"
            ip_address = "192.168.31.32/24"
            gateway = "192.168.31.1",
#            vlan_tag = 100,
            target_node = "proxmox",
            cpu_cores = 2,
            cpu_sockets = 2,
            memory = "8192",
            hdd_size = 40,
            vm_template = "ubuntu-2204-cloud",
            vmid = "302",
            ciuser = "ioc0",
            cipassword = "Depe8958",
        },
    }
}