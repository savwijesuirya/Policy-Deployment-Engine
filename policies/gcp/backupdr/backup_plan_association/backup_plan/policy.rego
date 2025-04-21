package terraform.gcp.security.backupdr.backup_plan_association.backup_plan

import data.terraform.gcp.security.backupdr.backup_plan_association.vars

# Collect all BackupPlanAssociation resources
all := [
  r |
    r := input.planned_values.root_module.resources[_]
    r.type == vars.resource_type
]

# Flag those with an empty backup_plan
violations := [
  sprintf("%s '%s' has invalid backup_plan: '%s'", [
    vars.friendly_resource_name,
    r.name,
    r.values.backup_plan,
  ]) |
  r := all[_]
  r.values.backup_plan == ""
]

# Build the summary payload under "message"
summary := {
  "message": array.concat(
    [
      sprintf("Total %s detected: %d", [
        vars.friendly_resource_name,
        count(all),
      ]),
      sprintf("Non-compliant %s: %d/%d", [
        vars.friendly_resource_name,
        count(violations),
        count(all),
      ]),
    ],
    violations
  )
}
