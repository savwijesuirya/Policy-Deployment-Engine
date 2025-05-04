package terraform.gcp.security.app_engine.https_only

import data.terraform.gcp.helpers
import data.terraform.gcp.security.app_engine.https_only.vars

attribute_path := "inbound_services"
compliant_values := [
  "INBOUND_SERVICE_HTTPS"
]

summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)
