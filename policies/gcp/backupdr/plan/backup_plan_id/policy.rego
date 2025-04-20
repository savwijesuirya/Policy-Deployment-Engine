package terraform.gcp.security.backupdr.backup_plan.backup_plan_id

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

attribute_path := "backup_plan_id"

compliant_values := [
  "backup-plan-simple-test"
]

summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)
