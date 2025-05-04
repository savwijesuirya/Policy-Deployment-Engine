package terraform.gcp.security.app_engine.iam_role_restriction

import data.terraform.gcp.helpers
import data.terraform.gcp.security.app_engine.iam_role_restriction.vars

attribute_path := "service_account.roles"
compliant_values := [
  "roles/viewer",
  "roles/logging.logWriter",
  "roles/monitoring.metricWriter"
]

summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)
