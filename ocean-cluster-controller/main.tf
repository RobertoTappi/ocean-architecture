module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_addons = var.cluster_addons

  vpc_id                   = var.vpc_id
  subnet_ids               = var.subnet_ids

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = var.eks_managed_node_group_defaults

  eks_managed_node_groups = var.eks_managed_node_groups

  # aws-auth configmap
  manage_aws_auth_configmap = var.manage_aws_auth_configmap

  aws_auth_roles = var.aws_auth_roles
  aws_auth_users = var.aws_auth_users

  tags = var.eks_tags
}


module "ocean-aws-k8s" {
  source = "spotinst/ocean-aws-k8s/spotinst"
  depends_on = [module.eks]

  # Configuration
  cluster_name                                 = var.cluster_name
  region                                       = var.region
  subnet_ids                                   = var.subnet_ids
  worker_instance_profile_arn                  = tolist(data.aws_iam_instance_profiles.profile.arns)[0]
  security_groups                              = [module.eks.node_security_group_id]
  should_tag_volumes                           = var.should_tag_volumes
  health_check_unhealthy_duration_before_replacement = var.health_check_unhealthy_duration_before_replacement
  
  shutdown_hours = var.shutdown_hours
  block_device_mappings = var.block_device_mappings
  tasks = var.tasks
  tags = var.tags

  # Load Balancer
  load_balancer = var.load_balancer

  # Update_policy
  should_roll           = var.should_roll
  auto_apply_tags       = var.auto_apply_tags
  batch_size_percentage = var.batch_size_percentage
  respect_pdb           = var.respect_pdb

  attach_load_balancer = var.attach_load_balancer
  detach_load_balancer = var.detach_load_balancer
}

module "ocean-controller" {
  source = "spotinst/ocean-controller/spotinst"

  depends_on = [module.ocean-aws-k8s]

  # Credentials.
  spotinst_token   = var.spotinst_token
  spotinst_account = var.spotinst_account

  # Configuration.
  tolerations = []
  cluster_identifier = var.cluster_name
}