## EKS Module
variable "cluster_version" {
  description = "K8s version"
  type        = string
}

variable "cluster_endpoint_public_access" {
  description = "Define se o endpoint do cluster deve estar acessível publicamente."
  type        = bool
}

variable "cluster_creator_admin_permissions" {
  description = "Admin access (default)"
  type        = bool
}
 
variable "cluster_name" {
  description = "Nome-cluster"
  type        = string
}

variable "subnet_ids" {
  description = "IDs subnets"
  type        = list(string)
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "cluster_addons" {
  description = "Configurações dos addons do cluster."
  type = object({
    coredns = object({
      most_recent = bool
    })
    kube-proxy = object({
      most_recent = bool
    })
    vpc-cni = object({
      most_recent = bool
    })
  })
}

variable "vpc_id" {
  description = "ID da VPC onde o cluster será criado."
  type        = string
}

variable "eks_managed_node_group_defaults" {
  description = "Configurações padrão dos grupos de nós gerenciados pelo EKS."
  type = object({
    instance_types = list(string)
  })
}

variable "eks_managed_node_groups" {
  description = "Configurações dos grupos de nós gerenciados pelo EKS."
  type = map(object({
    name           = string
    desired_size   = number
    min_size       = number
    max_size       = number
    instance_types = list(string)
    capacity_type  = string
  }))
}

variable "eks_tags" {
  description = "Tags para o cluster EKS."
  type        = map(string)
}

/*
# AWS-auth
variable "aws_auth_configmap" {
  description = "Define se o configmap aws-auth deve ser gerenciado."
  type        = bool
}

variable "aws_auth_roles" {
  description = "Lista de roles IAM a serem configuradas no configmap aws-auth."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
}

variable "aws_auth_users" {
  description = "Lista de usuários IAM a serem configurados no configmap aws-auth."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
}
*/

## Ocean-AWS-K8s Module ---------------------------
variable "instance_profile" {
  description = "Worker Node instance profile"
  type        = string
}

variable "spotinst_token" {
  description = "Spotinst API token"
  type        = string
}

variable "spotinst_account" {
  description = "Spotinst account ID"
  type        = string
}

/*
variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}
variable "region" {
  description = "AWS region"
  type        = string
}
variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}
*/

variable "security_groups" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "should_tag_volumes" {
  description = "Boolean to determine if volumes should be tagged"
  type        = bool
}

variable "health_check_unhealthy_duration_before_replacement" {
  description = "Duration before replacing an unhealthy node (in seconds)"
  type        = number
}

variable "shutdown_hours" {
  description = "Configuration for shutdown hours"
  type = object({
    is_enabled   = bool
    time_windows = list(string)
  })
}

variable "block_device_mappings" {
  description = "Block device mappings for instances"
  type = list(object({
    device_name           = string
    delete_on_termination = bool
    encrypted             = bool
    kms_key_id            = string
    snapshot_id           = string
    volume_type           = string
    volume_size           = number
    throughput            = number
    dynamic_volume_size = list(object({
      base_size              = number
      resource               = string
      size_per_resource_unit = number
    }))
    dynamic_iops = list(object({
      base_size              = number
      resource               = string
      size_per_resource_unit = number
    }))
  }))
}

variable "tasks" {
  description = "Scheduling tasks parameters (amiAutoUpdate and clusterRoll)"
  type = list(object({
    is_enabled      = bool
    cron_expression = string
    task_type       = string
    ami_auto_update = optional(list(object({
      apply_roll    = bool
      minor_version = bool
      patch         = bool
      ami_auto_update_cluster_roll = list(object({
        batch_min_healthy_percentage = number
        batch_size_percentage        = number
        comment                      = string
        respect_pdb                  = bool
      }))
    })))
    parameters_cluster_roll = optional(list(object({
      batch_min_healthy_percentage = number
      batch_size_percentage        = number
      comment                      = string
      respect_pdb                  = bool
    })))
  }))
}

variable "tags" {
  description = "Tags to apply to the Ocean resources"
  type        = map(string)
}

variable "should_roll" {
  description = "Define se deve haver um rollout durante a atualização."
  type        = bool
}

variable "auto_apply_tags" {
  description = "Define se as tags devem ser aplicadas automaticamente durante a atualização."
  type        = bool
}

variable "batch_size_percentage" {
  description = "Percentual do tamanho do lote para a atualização."
  type        = number
}

variable "respect_pdb" {
  description = "Define se o Pod Disruption Budget (PDB) deve ser respeitado durante a atualização."
  type        = bool
}

variable "load_balancer" {
  description = "Configurações dos load balancers associados."
  type = list(object({
    arn  = string
    name = string
    type = string
  }))
}

variable "attach_load_balancer" {
  description = "Lista de load balancers a serem associados."
  type = list(object({
    name = string
    type = string
    arn  = optional(string)
  }))
}

variable "detach_load_balancer" {
  description = "Lista de load balancers a serem desassociados."
  type = list(object({
    name = string
    type = string
    arn  = optional(string)
  }))
}


