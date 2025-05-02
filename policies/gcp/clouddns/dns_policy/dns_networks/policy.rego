package terraform.gcp.security.clouddns.dns_policy.dns_networks # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.clouddns.dns_policy.vars

attribute_path := "" # Edit here (eg., "storage_class")
compliant_values := [
   ""
]

summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)