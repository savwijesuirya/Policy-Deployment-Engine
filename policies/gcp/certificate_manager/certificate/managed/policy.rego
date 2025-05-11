package terraform.gcp.security.certificate_manager.certificate.managed # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.certificate.vars

attribute_path := "managed"
compliant_values := [
   [  # ← list of objects, matching the actual structure
    {
      "domains": ["correctfilelocation"],
      "dns_authorizations": null,
      "issuance_config": "correctissuance"
    }
  ]
]

summary := helpers.get_summary(
  vars.resource_type,
  attribute_path,
  compliant_values,
  vars.friendly_resource_name
)