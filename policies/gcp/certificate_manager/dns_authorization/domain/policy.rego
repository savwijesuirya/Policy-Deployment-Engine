package terraform.gcp.security.certificate_manager.dns_authorization.domain # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.dns_authorization.vars

attribute_path := "domain" 
compliant_values := ["test.example.com"]
summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)