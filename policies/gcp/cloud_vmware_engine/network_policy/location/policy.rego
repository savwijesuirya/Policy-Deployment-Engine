package terraform.gcp.security.cloud_vmware_engine.subnet.cidr_range # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.cloud_vmware_engine.subnet.vars

attribute_path := "ip_cidr_range" # Edit here (eg., "storage_class")
compliant_values := [
    "192.168.100.0/26",
]

summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)