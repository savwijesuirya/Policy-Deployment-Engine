package terraform.gcp.security.certificate_manager.certificate_issuance_config.key_algorithm# Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.certificate_issuance_config.vars

attribute_path := "key_algorithm"
compliant_values := [
    "ECDSA_P256"
]

summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)