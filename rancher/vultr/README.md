
# Vultr Rancher Quickstart

Two single-node Kubernetes clusters will be created from two droplets running Ubuntu 20.04 and Docker.
Both instances will be accessible over SSH using the SSH keys `id_rsa` and `id_rsa.pub`.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_vultr"></a> [vultr](#requirement\_vultr) | 2.11.4 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.2.3 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 3.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vultr"></a> [vultr](#provider\_vultr) | 2.11.4 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.2.3 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rancher_common"></a> [rancher\_common](#module\_rancher\_common) | ../rancher-common | n/a |

## Resources

| Name | Type |
|------|------|
| [vultr_instance.quickstart_node](https://registry.terraform.io/providers/vultr/vultr/latest/docs/resources/instance) | resource |
| [vultr_instance.rancher_server](https://registry.terraform.io/providers/vultr/vultr/latest/docs/resources/instance) | resource |
| [vultr_ssh_key.quickstart_ssh_key](https://registry.terraform.io/providers/vultr/vultr/latest/docs/resources/ssh_key) | resource |
| [local_file.ssh_public_key_openssh](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/resources/file) | resource |
| [local_sensitive_file.ssh_private_key_pem](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/resources/sensitive_file) | resource |
| [tls_private_key.global_key](https://registry.terraform.io/providers/hashicorp/tls/3.4.0/docs/resources/private_key) | resource |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_VULTR_API_KEY"></a> [input\_VULTR\_API_KEY](#input\_VULTR\_API\_KEY) | Vultr API token used to create infrastructure | `string` | n/a | yes |
| <a name="input_rancher_server_admin_password"></a> [rancher\_server\_admin\_password](#input\_rancher\_server\_admin\_password) | Admin password to use for Rancher server bootstrap, min. 12 characters | `string` | n/a | yes |
| <a name="input_cert_manager_version"></a> [cert\_manager\_version](#input\_cert\_manager\_version) | Version of cert-manager to install alongside Rancher (format: 0.0.0) | `string` | `"1.7.1"` | no |
| <a name="input_vultr_os"></a> [vultr\_os](#input\_vultr\_os) | Vultr OS used for all resources | `string` | `"270"` | no |
| <a name="input_vultr_region"></a> [vultr\_region](#input\_vultr\_region) | Vultr region used for all resources | `string` | `"syd"` | no |
| <a name="input_instance_size"></a> [instance\_size](#input\_instance\_size) | Instance size used for all instance| `string` | `"vc2-2c-4gb"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix added to names of all resources | `string` | `"quickstart"` | no |
| <a name="input_rancher_kubernetes_version"></a> [rancher\_kubernetes\_version](#input\_rancher\_kubernetes\_version) | Kubernetes version to use for Rancher server cluster | `string` | `"v1.24.4+k3s1"` | no |
| <a name="input_rancher_version"></a> [rancher\_version](#input\_rancher\_version) | Rancher server version (format: v0.0.0) | `string` | `"2.6.8"` | no |
| <a name="input_workload_kubernetes_version"></a> [workload\_kubernetes\_version](#input\_workload\_kubernetes\_version) | Kubernetes version to use for managed workload cluster | `string` | `"v1.24.4+rke2r1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rancher_node_ip"></a> [rancher\_node\_ip](#output\_rancher\_node\_ip) | n/a |
| <a name="output_rancher_server_url"></a> [rancher\_server\_url](#output\_rancher\_server\_url) | n/a |
| <a name="output_workload_node_ip"></a> [workload\_node\_ip](#output\_workload\_node\_ip) | n/a |

<!-- END_TF_DOCS -->

<!--

## API 
| for | command |
|-----|---------|
| Region List | `curl https://api.vultr.com/v1/regions/list | jq` |
| OS List | `curl https://api.vultr.com/v1/os/list | jq` |
| Instance Plan List | `curl https://api.vultr.com/v2/plans | jq` |

## Todo

 - [ ]  Static IP Reserve - [reserve\_rancher\_node\_ip](https://registry.terraform.io/providers/vultr/vultr/latest/docs/resources/reserved_ip)  
 - [ ]  Domain Mapping - [dns\_domain](https://registry.terraform.io/providers/vultr/vultr/latest/docs/resources/dns_domain)
 - [ ]  DNS Record - [dns\_record](https://registry.terraform.io/providers/vultr/vultr/latest/docs/resources/dns_record)

-->

