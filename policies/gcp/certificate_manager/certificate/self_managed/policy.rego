package terraform.gcp.security.certificate_manager.certificate.self_managed # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.certificate.vars

attribute_path := "self_managed"
compliant_values := [
   [  # ← list of objects, matching the actual structure
  { "pem_certificate" : "fileofcertificatepermissions",
   "pem_private_key" : "fileofprivatekey",
   "certificate_pem" : null,
   "private_key_pem" : null
  } 
   ]
]

summary := helpers.get_summary(
  vars.resource_type,
  attribute_path,
  compliant_values,
  vars.friendly_resource_name
)