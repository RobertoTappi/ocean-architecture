terraform {
  required_providers {
    spotinst = {
      source = "spotinst/spotinst"
    }
  }
}

provider "spotinst" {
  token   = var.spotinst_token
  account = var.spotinst_account
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

data "aws_iam_instance_profiles" "profile" {
  depends_on = [module.eks]
  role_name  = module.eks.eks_managed_node_groups["one"].iam_role_name
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

module "ocean-aws-k8s" {
  source = "spotinst/ocean-aws-k8s/spotinst"

  # Configuration
  cluster_name                                 = var.cluster_name
  region                                       = var.region
  subnet_ids                                   = var.subnet_ids
  worker_instance_profile_arn                  = tolist(data.aws_iam_instance_profiles.profile.arns)[0]
  security_groups                              = var.security_groups
  should_tag_volumes                           = var.should_tag_volumes
  health_check_unhealthy_duration_before_replacement = var.health_check_unhealthy_duration_before_replacement
  
  # Shutdown hours block
  shutdown_hours = var.shutdown_hours
  
  # Scheduling tasks parameters block (amiAutoUpdate and clusterRoll)
  tasks = var.tasks
     
  # Overwrite Name Tag and add additional
  tags = var.tags

  # Block Device Mappings
  block_device_mappings = var.block_device_mappings
}
