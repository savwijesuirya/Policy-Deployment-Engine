package terraform.gcp.security.certificate_manager.certificate_issuance_config.certificate_authority_config# Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.certificate_issuance_config.vars

attribute_path := "certificate_authority_config"
compliant_values := [
   [
    {
      "certificate_authority_service_config": [
        {
          "ca_pool": "correctcarpool"
        }
      ]
    }
  ]
]

summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)