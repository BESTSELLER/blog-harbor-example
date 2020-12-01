terraform {
  required_providers {
    harbor = {
      source  = "BESTSELLER/harbor"
      version = "1.0.0"
    }
  }
}

provider "harbor" {
  url      = "https://core.harbor.domain"
  username = "admin"
  password = "Harbor12345"
  insecure = true
}