
output "rancher_server_url" {
  value = module.rancher_common.rancher_url
}

output "rancher_node_ip" {
  value = vultr_instance.rancher_server.main_ip
}

output "workload_node_ip" {
  value = vultr_instance.quickstart_node.main_ip
}
