package terraform.gcp.security.certificate_manager.dns_authorization.type # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.dns_authorization.vars

attribute_path := "type" 
compliant_values := ["PER_PROJECT_RECORD"]
summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)