package terraform.gcp.security.certificate_manager.trust_config.allowlisted_certificates # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.trust_config.vars

attribute_path := "allowlisted_certificates" 
compliant_values := [[{"pem_certificate": "Allowedcertificate"}]]
summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)