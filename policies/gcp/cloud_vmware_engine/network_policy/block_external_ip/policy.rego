package terraform.gcp.security.cloud_vmware_engine.network_policy.block_external_ip # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.cloud_vmware_engine.network_policy.vars

attribute_path := "external_ip" # Edit here (eg., "storage_class")
compliant_values := false

summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)