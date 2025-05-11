package terraform.gcp.security.certificate_manager.trust_config.location # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.trust_config.vars

attribute_path := "location" 
compliant_values := ["AU"]
summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)