package terraform.gcp.security.certificate_manager.certificate_map_entry.certificate# Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.certificate_map_entry.vars

attribute_path := "certificates"
compliant_values := [
    ["correctcertificate"]
]

summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)