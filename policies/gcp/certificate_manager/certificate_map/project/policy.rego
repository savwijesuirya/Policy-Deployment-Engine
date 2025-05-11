package terraform.gcp.security.certificate_manager.certificate_map# Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.certificate_map.vars

attribute_path := "project"
compliant_values := [
    "correctprojectlocation"
]

summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)