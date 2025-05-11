package terraform.gcp.security.certificate_manager.trust_config.trust_stores # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.trust_config.vars

attribute_path := "trust_stores" 
compliant_values := [
  [
    {
      "intermediate_cas": [
        { "pem_certificate": "validsecurecertificate" }
      ],
      "trust_anchors": [
        { "pem_certificate": "validsecurecertificate" }
      ]
    }
  ]
 
 ]
summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)