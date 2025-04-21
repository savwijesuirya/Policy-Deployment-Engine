package terraform.gcp.security.backupdr.backup_plan_association.project

import data.terraform.gcp.security.backupdr.backup_plan_association.vars

# collect all BPA resources
all := [
  r | 
    r := input.planned_values.root_module.resources[_]
    r.type == vars.resource_type
]

# flag those whose project isn’t the approved one
violations := [
  sprintf("%s '%s' uses unapproved project: '%s'", [
    vars.friendly_resource_name,
    r.name,
    r.values.project,
  ]) |
  r := all[_]
  not r.values.project == "my-project-id"
]

# build the payload under "message"
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
