terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "2.11.4"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.4.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "vultr" {
  api_key     = var.VULTR_API_KEY
  rate_limit  = 700
  retry_limit = 3
}
