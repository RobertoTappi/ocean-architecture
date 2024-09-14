variable "spotinst_token" {
  description = "Spotinst API token"
  type        = string
  default = null
}

variable "spotinst_account" {
  description = "Spotinst account ID"
  type        = string
  default = null
}

variable "ocean_id" {
  description = "Ocean ID for the node groups"
  type        = string
  default = null
}

variable "vng_stateless_name" {
  description = "Name of the stateless Virtual Node Group"
  type        = string
  default     = "stateless"
}

variable "vng_stateless_labels" {
  description = "Labels for the stateless Virtual Node Group"
  type        = list(object({ key = string, value = string }))
  default     = [{ key = "type", value = "stateless" }]
}

variable "vng_gpu_name" {
  description = "Name of the GPU Virtual Node Group"
  type        = string
  default     = "gpu"
}

variable "vng_gpu_labels" {
  description = "Labels for the GPU Virtual Node Group"
  type        = list(object({ key = string, value = string }))
  default     = [{ key = "type", value = "gpu" }]
}

variable "vng_gpu_taints" {
  description = "Taints for the GPU Virtual Node Group"
  type        = list(object({ key = string, value = string, effect = string }))
  default     = [{ key = "type", value = "gpu", effect = "NoSchedule" }]
}

variable "vng_gpu_spot_percentage" {
  description = "Spot percentage for the GPU Virtual Node Group"
  type        = number
  default     = 50
}

variable "vng_gpu_draining_timeout" {
  description = "Draining timeout for the GPU Virtual Node Group"
  type        = number
  default     = 300
}

variable "vng_test_name" {
  description = "Name of the test Virtual Node Group"
  type        = string
  default = null
}

variable "instance_types_filters_categories" {
  description = "Instance type categories for filtering"
  type        = list(string)
  default     = ["Accelerated_computing", "Compute_optimized"]
}

variable "instance_types_filters_disk_types" {
  description = "Disk types for instance type filtering"
  type        = list(string)
  default     = ["NVMe", "EBS"]
}

variable "instance_types_filters_exclude_families" {
  description = "Instance families to exclude from filtering"
  type        = list(string)
  default     = ["t2", "R4*"]
}

variable "instance_types_filters_exclude_metal" {
  description = "Exclude metal instances from filtering"
  type        = bool
  default     = true
}

variable "instance_types_filters_hypervisor" {
  description = "Hypervisor types for instance type filtering"
  type        = list(string)
  default     = ["nitro"]
}

variable "instance_types_filters_include_families" {
  description = "Instance families to include in filtering"
  type        = list(string)
  default     = ["c5*", "g5"]
}

variable "instance_types_filters_is_ena_supported" {
  description = "Filter for ENA supported instances"
  type        = bool
  default     = true
}

variable "instance_types_filters_max_gpu" {
  description = "Maximum number of GPUs for filtering"
  type        = number
  default     = 4
}

variable "instance_types_filters_min_gpu" {
  description = "Minimum number of GPUs for filtering"
  type        = number
  default     = 0
}

variable "instance_types_filters_max_memory_gib" {
  description = "Maximum memory in GiB for filtering"
  type        = number
  default     = 16
}

variable "instance_types_filters_max_network_performance" {
  description = "Maximum network performance for filtering"
  type        = number
  default     = 20
}

variable "instance_types_filters_max_vcpu" {
  description = "Maximum vCPU count for filtering"
  type        = number
  default     = 16
}

variable "instance_types_filters_min_enis" {
  description = "Minimum number of ENIs for filtering"
  type        = number
  default     = 2
}

variable "instance_types_filters_min_memory_gib" {
  description = "Minimum memory in GiB for filtering"
  type        = number
  default     = 8
}

variable "instance_types_filters_min_network_performance" {
  description = "Minimum network performance for filtering"
  type        = number
  default     = 2
}

variable "instance_types_filters_min_vcpu" {
  description = "Minimum vCPU count for filtering"
  type        = number
  default     = 2
}

variable "instance_types_filters_root_device_types" {
  description = "Root device types for filtering"
  type        = list(string)
  default     = ["ebs"]
}

variable "instance_types_filters_virtualization_types" {
  description = "Virtualization types for filtering"
  type        = list(string)
  default     = ["hvm"]
}

variable "images" {
  description = "List of images to be used"
  type        = list(object({ image_id = string }))
  default     = [{ image_id = "ami-123456" }, { image_id = "ami-67890" }]
}

variable "block_device_mappings" {
  description = "Block device mappings for instances"
  type = list(object({
    device_name = string
    encrypted   = bool
    volume_type = string 
  }))
  default = [{
    device_name = "/dev/xvda"
    encrypted   = false
    volume_type = "gp3"
  }]
}

variable "dynamic_volume_size" {
  description = "Dynamic volume size configuration"
  type = object({
    base_size              = number
    resource               = string
    size_per_resource_unit = number
  })
  default = {
    base_size              = 50
    resource               = "CPU"
    size_per_resource_unit = 20
  }
}

variable "ephemeral_storage_device_name" {
  description = "Device name for ephemeral storage"
  type        = string
  default     = "/dev/xvdb"
}

variable "preferred_spot_types" {
  description = "Preferred instance types for spot instances"
  type        = list(string)
  default     = ["m4.xlarge", "c3.large"]
}

variable "preferred_od_types" {
  description = "Preferred instance types for on-demand instances"
  type        = list(string)
  default     = ["t3.medium", "c4.large"]
}
