package terraform.gcp.security.certificate_manager.certificate.project # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.certificate.vars

attribute_path := "project"
compliant_values := [
  "fake-policy-test-project"
   
]

summary := helpers.get_summary(
  vars.resource_type,
  attribute_path,
  compliant_values,
  vars.friendly_resource_name
)