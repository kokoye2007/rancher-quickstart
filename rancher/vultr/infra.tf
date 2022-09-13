# VULTR infrastructure resources

resource "tls_private_key" "global_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "ssh_private_key_pem" {
  filename        = "${path.module}/id_rsa"
  content         = tls_private_key.global_key.private_key_pem
  file_permission = "0600"
}

resource "local_file" "ssh_public_key_openssh" {
  filename = "${path.module}/id_rsa.pub"
  content  = tls_private_key.global_key.public_key_openssh
}

# Temporary key pair used for SSH accesss
resource "vultr_ssh_key" "quickstart_ssh_key" {
  name    = "instance-ssh-key"
  ssh_key = tls_private_key.global_key.public_key_openssh
}

## Vultr Instance for creating a single node RKE cluster and installing the Rancher server
resource "vultr_instance" "rancher_server" {
  #  hostname = "${var.prefix}"-rancher
  plan              = var.plan
  os_id             = var.os_id
  region            = var.vultr_region
  vpc_ids           = [vultr_vpc.rancher-vpc.id]
  firewall_group_id = vultr_firewall_group.rancher_firewall.id
  ssh_key_ids       = [vultr_ssh_key.quickstart_ssh_key.id]

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
      "ufw disable",
    ]

    connection {
      type        = "ssh"
      host        = self.main_ip
      user        = local.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
}

# Rancher resources
module "rancher_common" {
  source = "../rancher-common"

  node_public_ip             = vultr_instance.rancher_server.main_ip
  node_internal_ip           = vultr_instance.rancher_server.internal_ip
  node_username              = local.node_username
  ssh_private_key_pem        = tls_private_key.global_key.private_key_pem
  rancher_kubernetes_version = var.rancher_kubernetes_version

  cert_manager_version = var.cert_manager_version
  rancher_version      = var.rancher_version

  rancher_server_dns = join(".", ["rancher", vultr_instance.rancher_server.main_ip, "sslip.io"])
  admin_password     = var.rancher_server_admin_password

  workload_kubernetes_version = var.workload_kubernetes_version
  workload_cluster_name       = "quickstart-vultr-custom"
}

# Vultr instance for creating a single node workload cluster
resource "vultr_instance" "quickstart_node" {
  #  name     = "${var.prefix}-quickstart-node"
  os_id             = var.os_id
  region            = var.vultr_region
  plan              = var.plan
  vpc_ids           = [vultr_vpc.rancher-vpc.id]
  firewall_group_id = vultr_firewall_group.rancher_firewall.id
  ssh_key_ids       = [vultr_ssh_key.quickstart_ssh_key.id]

  user_data = base64encode(templatefile(
    join("/", [path.module, "files/userdata_quickstart_node.template"]),
    {
      username         = local.node_username
      register_command = module.rancher_common.custom_cluster_command
    }
  ))

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
      "ufw disable",
    ]

    connection {
      type        = "ssh"
      host        = self.main_ip
      user        = local.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
}
