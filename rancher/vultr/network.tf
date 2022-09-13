# Vultr VPC
resource "vultr_vpc" "rancher-vpc" {
  description    = "rancher vpc"
  region         = var.vultr_region
  v4_subnet      = "10.0.0.0"
  v4_subnet_mask = 24
}

# Vultr Firewall Group
resource "vultr_firewall_group" "rancher_firewall" {
  description = "rancher firewall"
}

resource "vultr_firewall_rule" "rancher_k8s_port" {
  firewall_group_id = vultr_firewall_group.rancher_firewall.id
  protocol          = "tcp"
  ip_type           = "v4"
  subnet            = "0.0.0.0"
  subnet_size       = 0
  port              = "1-65535"
  notes             = "Rancher K8s Rules"
}

resource "vultr_firewall_rule" "rancher_k8s_port_udp" {
  firewall_group_id = vultr_firewall_group.rancher_firewall.id
  protocol          = "udp"
  ip_type           = "v4"
  subnet            = "0.0.0.0"
  subnet_size       = 0
  port              = "1-65535"
  notes             = "Rancher K8s UDP Rules"
}

#Vultr Firewall Rules

#resource "vultr_firewall_rule" "rancher_k8s_port" {
#  firewall_group_id = vultr_firewall_group.rancher_firewall.id
#  protocol          = "tcp"
#  ip_type           = "v4"
#  subnet            = "0.0.0.0"
#  subnet_size       = 0
#  port              = "22,80,179,443,2376,2379,2380,5473,6443,6783,8080,8443,8472,9090,9099,9100,9345,9443,9796,10250,10254,30000-32767"
#  notes             = "Rancher K8s Rules"
#}
#
#resource "vultr_firewall_rule" "rancher_k8s_port_udp" {
#  firewall_group_id = vultr_firewall_group.rancher_firewall.id
#  protocol          = "udp"
#  ip_type           = "v4"
#  subnet            = "0.0.0.0"
#  subnet_size       = 0
#  port              = "8472,6783-6784,30000-32767"
#  notes             = "Rancher K8s UDP Rules"
#}
