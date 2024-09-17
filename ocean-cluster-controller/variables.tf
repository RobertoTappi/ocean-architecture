## EKS Module
variable "cluster_version" {
  description = "Spotinst API token"
  type        = string
  default     = null
}

variable "cluster_endpoint_public_access" {
  description = "Define se o endpoint do cluster deve estar acessível publicamente."
  type        = bool
  default     = true
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

  default = {
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

  default = {
    instance_types = []
  }
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

  default = {
    one = {
      name           = "default-node-group"
      desired_size   = 0
      min_size       = 0
      max_size       = 0
      instance_types = []
      capacity_type  = "SPOT"
    }
  }
}

# AWS-auth
variable "manage_aws_auth_configmap" {
  description = "Define se o configmap aws-auth deve ser gerenciado."
  type        = bool
  default     = true
}

variable "aws_auth_roles" {
  description = "Lista de roles IAM a serem configuradas no configmap aws-auth."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "aws_auth_users" {
  description = "Lista de usuários IAM a serem configurados no configmap aws-auth."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "eks_tags" {
  description = "Tags para o cluster EKS."
  type        = map(string)
  default     = {}
}


## Ocean-AWS-K8s Module
variable "spotinst_token" {
  description = "Spotinst API token"
  type        = string
  default     = null
}

variable "spotinst_account" {
  description = "Spotinst account ID"
  type        = string
  default     = null
}

variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
  default     = null
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
  default     = []
}

variable "security_groups" {
  description = "List of security group IDs"
  type        = list(string)
  default     = []
}

variable "should_tag_volumes" {
  description = "Boolean to determine if volumes should be tagged"
  type        = bool
  default     = false
}

variable "health_check_unhealthy_duration_before_replacement" {
  description = "Duration before replacing an unhealthy node (in seconds)"
  type        = number
  default     = 60
}

variable "shutdown_hours" {
  description = "Configuration for shutdown hours"
  type = object({
    is_enabled   = bool
    time_windows = list(string)
  })

  default = {
    is_enabled   = false
    time_windows = ["Sat:08:00-Sun:08:00"]
  }
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

  default = [{
    device_name           = null
    delete_on_termination = false
    encrypted             = false
    kms_key_id            = null
    snapshot_id           = null
    volume_type           = null
    volume_size           = 0
    throughput            = 0
    dynamic_volume_size = [{
      base_size              = 0
      resource               = null
      size_per_resource_unit = 0
    }]
    dynamic_iops = [{
      base_size              = 0
      resource               = null
      size_per_resource_unit = 0
    }]
  }]
}

variable "tasks" {
  description = "Scheduling tasks parameters (amiAutoUpdate and clusterRoll)"
  type = list(object({
    is_enabled      = bool
    cron_expression = string
    task_type       = string
    ami_auto_update = list(object({
      apply_roll    = bool
      minor_version = bool
      patch         = bool
      ami_auto_update_cluster_roll = list(object({
        batch_min_healthy_percentage = number
        batch_size_percentage        = number
        comment                      = string
        respect_pdb                  = bool
      }))
    }))
    parameters_cluster_roll = list(object({
      batch_min_healthy_percentage = number
      batch_size_percentage        = number
      comment                      = string
      respect_pdb                  = bool
    }))
  }))

  default = [
    {
      is_enabled      = false
      cron_expression = null
      task_type       = null
      ami_auto_update = [{
        apply_roll    = false
        minor_version = false
        patch         = false
        ami_auto_update_cluster_roll = [{
          batch_min_healthy_percentage = 0
          batch_size_percentage        = 0
          comment                      = null
          respect_pdb                  = false
        }]
      }]
    },
    {
      is_enabled      = false
      cron_expression = null
      task_type       = null
      parameters_cluster_roll = [{
        batch_min_healthy_percentage = 0
        batch_size_percentage        = 0
        comment                      = null
        respect_pdb                  = false
      }]
    }
  ]
}

variable "tags" {
  description = "Tags to apply to the Ocean resources"
  type        = map(string)

  default = {
    Name      = null
    CreatedBy = null
  }
}

variable "load_balancer" {
  description = "Configurações dos load balancers associados."
  type = list(object({
    arn  = string
    name = string
    type = string
  }))
  default = []
}

variable "should_roll" {
  description = "Define se deve haver um rollout durante a atualização."
  type        = bool
  default     = true
}

variable "auto_apply_tags" {
  description = "Define se as tags devem ser aplicadas automaticamente durante a atualização."
  type        = bool
  default     = true
}

variable "batch_size_percentage" {
  description = "Percentual do tamanho do lote para a atualização."
  type        = number
  default     = 20
}

variable "respect_pdb" {
  description = "Define se o Pod Disruption Budget (PDB) deve ser respeitado durante a atualização."
  type        = bool
  default     = false
}

variable "attach_load_balancer" {
  description = "Lista de load balancers a serem associados."
  type = list(object({
    name = string
    type = string
    arn  = optional(string)
  }))
  default = []
}

variable "detach_load_balancer" {
  description = "Lista de load balancers a serem desassociados."
  type = list(object({
    name = string
    type = string
    arn  = optional(string)
  }))
  default = []
}
