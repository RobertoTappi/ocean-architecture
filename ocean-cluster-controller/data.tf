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