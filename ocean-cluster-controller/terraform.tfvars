## Variables EKS module
cluster_version = ""
cluster_endpoint_public_access = true
cluster_creator_admin_permissions = true
cluster_name = ""
subnet_ids = []
region = ""

cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
}

vpc_id = ""

eks_managed_node_group_defaults = {
    instance_types = []
}

eks_managed_node_groups = {
    one = {
      name           = ""
      desired_size   = 0
      min_size       = 0
      max_size       = 0
      instance_types = []
      capacity_type  = ""
    }
}

eks_tags = {
  "example-tag" = "string"
}
/*
aws_auth_configmap = true

aws_auth_roles = [{
    rolearn = "string"
    username = "string"
    groups = ["string"]
}]

aws_auth_users = [{
    rolearn = "string"
    username = "string"
    groups = ["string"]
}]
*/

## Ocean-AWS-K8s module
instance_profile = ""
spotinst_token = ""
spotinst_account = ""

security_groups = []
should_tag_volumes = true
health_check_unhealthy_duration_before_replacement = 0

shutdown_hours = {
    is_enabled   = false
    time_windows = []
}

block_device_mappings = [{
    device_name           = ""
    delete_on_termination = false
    encrypted             = true
    kms_key_id            = ""
    snapshot_id           = null
    volume_type           = ""
    volume_size           = null
    throughput            = 0
    dynamic_volume_size = [{
      base_size              = 0
      resource               = "CPU"
      size_per_resource_unit = 0
    }]
    dynamic_iops = [{
      base_size              = 0
      resource               = "CPU"
      size_per_resource_unit = 0
    }]
}]

tasks = [
    {
      is_enabled      = false
      cron_expression = "0 9 * * *" 
      task_type       = "amiAutoUpdate"
      ami_auto_update = [{
        apply_roll    = false
        minor_version = false
        patch         = true
        ami_auto_update_cluster_roll = [{
          batch_min_healthy_percentage = 0
          batch_size_percentage        = 0
          comment                      = "Comments for AmiAutUpdate Cluster Roll"
          respect_pdb                  = false
        }]
      }]
    },
    {
      is_enabled      = false
      cron_expression = "0 5 * * *" 
      task_type       = "clusterRoll"
      ami_auto_update = [] 
      parameters_cluster_roll = [{
        batch_min_healthy_percentage = 0
        batch_size_percentage        = 0
        comment                      = "Comments for Parameters Cluster Roll"
        respect_pdb                  = false
      }]
}]

tags = {
    Name      = ""
    CreatedBy = ""
}

should_roll = false
auto_apply_tags = true
batch_size_percentage = 0
respect_pdb = false

load_balancer = [{
    arn = null
    name = null
    type = null
}]

attach_load_balancer = [{
    name = null
    type = null
    arn = null
}]

detach_load_balancer = [{
    name = null
    type = null
    arn = null
}]
