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
  default     = 300
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
