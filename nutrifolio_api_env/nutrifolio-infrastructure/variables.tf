variable "region" {
  default = "fra1"
}

variable "environment" {
  default = "Development"

  validation {
    condition     = (var.environment == "Development" || var.environment == "Production")
    error_message = "Environment must be either Development or Production"
  }
}

variable "ssh-key-name" {}

variable "vpc-name" {}

variable "sb-name" {}

variable "db-cluster-name" {}

variable "domain-name" {}
