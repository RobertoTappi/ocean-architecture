variable "spotinst_token" {
  description = "Spotinst API token"
  type        = string
}

variable "spotinst_account" {
  description = "Spotinst account ID"
  type        = string
}

variable "ocean_id" {
  description = "Ocean ID for the node groups"
  type        = string
}
/*
variable "vng_stateless_name" {
  description = "Name of the stateless Virtual Node Group"
  type        = string
}

variable "vng_stateless_labels" {
  description = "Labels for the stateless Virtual Node Group"
  type        = list(object({ key = string, value = string }))
}

variable "vng_gpu_name" {
  description = "Name of the GPU Virtual Node Group"
  type        = string
}

variable "vng_gpu_labels" {
  description = "Labels for the GPU Virtual Node Group"
  type        = list(object({ key = string, value = string }))
}

variable "vng_gpu_taints" {
  description = "Taints for the GPU Virtual Node Group"
  type        = list(object({ key = string, value = string, effect = string }))
}

variable "vng_gpu_spot_percentage" {
  description = "Spot percentage for the GPU Virtual Node Group"
  type        = number
}

variable "vng_gpu_draining_timeout" {
  description = "Draining timeout for the GPU Virtual Node Group"
  type        = number
}
*/
variable "vng_test_name" {
  description = "Name of the test Virtual Node Group"
  type        = string
}

variable "instance_types_filters_enable" {
  description = "Enable/disable instance tyoe filters"
  type = bool
}

variable "instance_types_filters_categories" {
  description = "Instance type categories for filtering"
  type        = list(string)
}

variable "instance_types_filters_disk_types" {
  description = "Disk types for instance type filtering"
  type        = list(string)
}

variable "instance_types_filters_include_families" {
  description = "Instance families to include in filtering"
  type        = list(string)
}

variable "instance_types_filters_exclude_families" {
  description = "Instance families to exclude from filtering"
  type        = list(string)
}

variable "instance_types_filters_exclude_metal" {
  description = "Exclude metal instances from filtering"
  type        = bool
  default     = true
}

variable "instance_types_filters_hypervisor" {
  description = "Hypervisor types for instance type filtering"
  type        = list(string)
}

variable "instance_types_filters_is_ena_supported" {
  description = "Filter for ENA supported instances"
  type        = bool
}

variable "instance_types_filters_max_gpu" {
  description = "Maximum number of GPUs for filtering"
  type        = number
}

variable "instance_types_filters_min_gpu" {
  description = "Minimum number of GPUs for filtering"
  type        = number
}

variable "instance_types_filters_max_memory_gib" {
  description = "Maximum memory in GiB for filtering"
  type        = number
}

variable "instance_types_filters_min_memory_gib" {
  description = "Minimum memory in GiB for filtering"
  type        = number
}

variable "instance_types_filters_max_network_performance" {
  description = "Maximum network performance for filtering"
  type        = number
}

variable "instance_types_filters_min_network_performance" {
  description = "Minimum network performance for filtering"
  type        = number
}

variable "instance_types_filters_max_vcpu" {
  description = "Maximum vCPU count for filtering"
  type        = number
}

variable "instance_types_filters_min_vcpu" {
  description = "Minimum vCPU count for filtering"
  type        = number
}

variable "instance_types_filters_min_enis" {
  description = "Minimum number of ENIs for filtering"
  type        = number
}

variable "instance_types_filters_root_device_types" {
  description = "Root device types for filtering"
  type        = list(string)
}

variable "instance_types_filters_virtualization_types" {
  description = "Virtualization types for filtering"
  type        = list(string)
}

variable "images" {
  description = "List of images to be used"
  type        = list(object({ image_id = string }))
}

variable "block_device_mappings" {
  description = "Block device mappings for instances"
  type = list(object({
    device_name = string
    encrypted   = bool
    volume_type = string 
  }))
}

variable "dynamic_volume_size" {
  description = "Dynamic volume size configuration"
  type = object({
    base_size              = number
    resource               = string
    size_per_resource_unit = number
  })
}

variable "ephemeral_storage_device_name" {
  description = "Device name for ephemeral storage"
  type        = string
}

variable "preferred_spot_types" {
  description = "Preferred instance types for spot instances"
  type        = list(string)
}

variable "preferred_od_types" {
  description = "Preferred instance types for on-demand instances"
  type        = list(string)
}

variable "scheduling_shutdown_hours" {
  type = object({
    is_enabled   = bool
    time_windows = list(string)
  })
}

variable "scheduling_task" {
  type = list(object({
    is_enabled      = bool
    cron_expression = string
    task_type       = string
    num_of_units    = number
    cpu_per_unit    = number
    gpu_per_unit    = number
    memory_per_unit = number
  }))
}

