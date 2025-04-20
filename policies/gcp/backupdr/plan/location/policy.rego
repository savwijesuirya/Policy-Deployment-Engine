package terraform.gcp.security.backupdr.backup_plan.location

import data.terraform.gcp.security.backupdr.backup_plan.vars

compliant_location := "australia-southeast1"

resources := [r |
  r := input.planned_values.root_module.resources[_]
  r.type == vars.resource_type
]

non_compliant := [r |
  r := resources[_]
  r.values.location != compliant_location
]

violation_msgs := [sprintf("%s '%s' uses unapproved location: '%s'", [vars.friendly_resource_name, r.name, r.values.location]) | r := non_compliant[_]]

summary_msgs := [
  sprintf("Total %s detected: %d", [vars.friendly_resource_name, count(resources)]),
  sprintf("Non-compliant %s: %d/%d", [vars.friendly_resource_name, count(non_compliant), count(resources)])
]

summary := array.concat(summary_msgs, violation_msgs)
