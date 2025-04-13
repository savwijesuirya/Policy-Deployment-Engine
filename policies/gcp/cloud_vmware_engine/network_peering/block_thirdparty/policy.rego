package terraform.gcp.security.cloud_vmware_engine.network_peering.block_thirdparty # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.cloud_vmware_engine.network_peering.vars

attribute_path := "peer_network_type" # Edit here (eg., "storage_class")
compliant_values := [
    "STANDARD",
    "VMWARE_ENGINE_NETWORK",
    "PRIVATE_SERVICES_ACCESS",
    "NETAPP_CLOUD_VOLUMES",
    "DELL_POWERSCALE"
]

summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)