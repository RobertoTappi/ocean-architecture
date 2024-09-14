terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.70"
    }
    spotinst = {
      source  = "spotinst/spotinst"
      version = ">=1.142.0"
    }
  }
}

provider "aws" {
  region = var.region-name
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "ocean-controller" {
  source = "spotinst/ocean-controller/spotinst"

  # Credentials.
  spotinst_token   = var.spotinst_token
  spotinst_account = var.spotinst_account

  # Configuration.
  cluster_identifier = var.cluster_identifier
}
