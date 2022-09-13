# Variables for Vultr infrastructure module

variable "VULTR_API_KEY" {
  type        = string
  description = "Vultr API token used to create infrastructure"
}

variable "vultr_region" {
  type        = string
  description = "Vultr region used for all resources"
  default     = "syd"
}

variable "os_id" {
  type        = string
  description = "Vultr OS used for all resources"
  default     = "270"
}

variable "prefix" {
  type        = string
  description = "Prefix added to names of all resources"
  default     = "quickstart"
}

variable "plan" {
  type        = string
  description = "Instant size used for all Instant"
  default     = "vc2-2c-4gb"
}

variable "rancher_kubernetes_version" {
  type        = string
  description = "Kubernetes version to use for Rancher server cluster"
  default     = "v1.23.10+k3s1"
}

variable "workload_kubernetes_version" {
  type        = string
  description = "Kubernetes version to use for managed workload cluster"
  default     = "v1.23.10+rke2r1"
}

variable "cert_manager_version" {
  type        = string
  description = "Version of cert-manager to install alongside Rancher (format: 0.0.0)"
  default     = "1.7.1"
}

variable "rancher_version" {
  type        = string
  description = "Rancher server version (format: v0.0.0)"
  default     = "2.6.8"
}

variable "rancher_server_admin_password" {
  type        = string
  description = "Admin password to use for Rancher server bootstrap, min. 12 characters"
}

# Local variables used to reduce repetition
locals {
  node_username = "root"
}
