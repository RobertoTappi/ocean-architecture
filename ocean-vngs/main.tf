terraform {
  required_version = var.required_version

  required_providers {
    spotinst = {
      source  = "spotinst/spotinst"
      version = var.spotinst_version
    }
  }
}

provider "spotinst" {
  token   = var.spotinst_token
  account = var.spotinst_account
}

## Create Ocean Virtual Node Group (launchspec) ##
module "ocean-aws-k8s-vng_stateless" {
  source   = "spotinst/ocean-aws-k8s-vng/spotinst"
  name     = var.vng_stateless_name # Name of VNG in Ocean
  ocean_id = var.ocean_id
  labels   = var.vng_stateless_labels
}

## Create additional Ocean Virtual Node Group (launchspec) ##
module "ocean-aws-k8s-vng_gpu" {
  source            = "spotinst/ocean-aws-k8s-vng/spotinst"
  name              = var.vng_gpu_name # Name of VNG in Ocean
  ocean_id          = var.ocean_id
  labels            = var.vng_gpu_labels
  taints            = var.vng_gpu_taints
  spot_percentage   = var.vng_gpu_spot_percentage
  draining_timeout  = var.vng_gpu_draining_timeout
}

## Create Ocean Virtual Node Group (launchSpec) with instance_type_filters ##
module "ocean-aws-k8s-vng" {
  source                                   = "spotinst/ocean-aws-k8s-vng/spotinst"
  ocean_id                                 = var.ocean_id
  name                                     = var.vng_test_name
  instance_types_filters_enable            = true
  instance_types_filters_categories        = var.instance_types_filters_categories
  instance_types_filters_disk_types        = var.instance_types_filters_disk_types
  instance_types_filters_exclude_families  = var.instance_types_filters_exclude_families
  instance_types_filters_exclude_metal     = var.instance_types_filters_exclude_metal
  instance_types_filters_hypervisor        = var.instance_types_filters_hypervisor
  instance_types_filters_include_families  = var.instance_types_filters_include_families
  instance_types_filters_is_ena_supported  = var.instance_types_filters_is_ena_supported
  instance_types_filters_max_gpu           = var.instance_types_filters_max_gpu
  instance_types_filters_min_gpu           = var.instance_types_filters_min_gpu
  instance_types_filters_max_memory_gib    = var.instance_types_filters_max_memory_gib
  instance_types_filters_max_network_performance = var.instance_types_filters_max_network_performance
  instance_types_filters_max_vcpu          = var.instance_types_filters_max_vcpu
  instance_types_filters_min_enis          = var.instance_types_filters_min_enis
  instance_types_filters_min_memory_gib    = var.instance_types_filters_min_memory_gib
  instance_types_filters_min_network_performance = var.instance_types_filters_min_network_performance
  instance_types_filters_min_vcpu          = var.instance_types_filters_min_vcpu
  instance_types_filters_root_device_types = var.instance_types_filters_root_device_types
  instance_types_filters_virtualization_types = var.instance_types_filters_virtualization_types
  images                                   = var.images
  block_device_mappings                    = var.block_device_mappings
  dynamic_volume_size                      = var.dynamic_volume_size
  ephemeral_storage_device_name            = var.ephemeral_storage_device_name
  preferred_spot_types                     = var.preferred_spot_types
  preferred_od_types                       = var.preferred_od_types
}
