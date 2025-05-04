package terraform.gcp.security.certificate_manager.certificate.scope # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.certificate.vars

attribute_path := "scope" 
compliant_values := ["CLIENT_AUTH"]
summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)