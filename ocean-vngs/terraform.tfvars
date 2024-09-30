spotinst_token = ""
spotinst_account = ""
ocean_id = ""

/*
vng_stateless_name = "stateless"
vng_stateless_labels = [{
    key = "type"
    value = "stateless" 
}]

vng_gpu_name = "gpu"
vng_gpu_labels = [{
    key = "type"
    value = "gpu" 
}]

vng_gpu_taints = [{
    key = "type"
    value = "gpu"
    effect = "NoSchedule"
}]

vng_gpu_spot_percentage = 0
vng_gpu_draining_timeout = 0
*/

vng_test_name = ""
instance_types_filters_enable = true
instance_types_filters_categories = []
instance_types_filters_disk_types = []

instance_types_filters_include_families = []
instance_types_filters_exclude_families = []

instance_types_filters_exclude_metal = true
instance_types_filters_hypervisor = []
instance_types_filters_is_ena_supported = true

instance_types_filters_max_gpu = 0
instance_types_filters_min_gpu = 0

instance_types_filters_max_memory_gib = 0
instance_types_filters_min_memory_gib = 0

instance_types_filters_max_network_performance = 0
instance_types_filters_min_network_performance = 0

instance_types_filters_max_vcpu = 0
instance_types_filters_min_vcpu = 0

instance_types_filters_min_enis = 0
instance_types_filters_root_device_types = []
instance_types_filters_virtualization_types = []

images = [{ 
    image_id = ""
}]

block_device_mappings = [{
    device_name = ""
    encrypted   = true
    volume_type = ""
}]

dynamic_volume_size = {
    base_size              = 0
    resource               = "CPU"
    size_per_resource_unit = 0
}

ephemeral_storage_device_name = ""
preferred_spot_types = []
preferred_od_types = []

scheduling_shutdown_hours = {
    is_enabled = false
    time_windows = []
}

scheduling_task = [
  {
    is_enabled      = false
    cron_expression = "0 1 * * *"
    task_type       = "manualHeadroomUpdate"
    num_of_units    = 0
    cpu_per_unit    = 0
    gpu_per_unit    = 0
    memory_per_unit = 0
  },
  {
    is_enabled      = false
    cron_expression = "0 2 * * *"
    task_type       = "manualHeadroomUpdate"
    num_of_units    = 0
    cpu_per_unit    = 0
    gpu_per_unit    = 0
    memory_per_unit = 0
  }
]
