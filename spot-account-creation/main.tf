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

module "spotinst-aws-connect" {
    source = "spotinst/aws-connect/spotinst"
    
    #Name for the Spot account. The account name must contain at least one character that is a-z or A-Z

    name = var.account-name
    spotinst_token = var.spotinst_token

    #Policy File (Optional) File with policy to attach to the Spot role

    policy_file = templatefile(var.policy_file, {
       region     = var.region-name
       account_id = var.account-id })
}