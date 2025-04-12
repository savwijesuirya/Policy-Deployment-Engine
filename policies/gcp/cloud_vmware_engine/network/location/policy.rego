package terraform.gcp.security.cloud_vmware_engine.network.location # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.cloud_vmware_engine.network.vars

attribute_path := "location" # Edit here (eg., "storage_class")
compliant_values := [
    "australia-southeast2",
    "australia-southeast1"
]

summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)