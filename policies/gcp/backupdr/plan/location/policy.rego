package terraform.gcp.security.backupdr.backup_plan.location

import data.terraform.gcp.security.backupdr.backup_plan.vars

# the only approved location
compliant_location := "australia-southeast1"

# gather all backup_plan resources
resources := [
  r |
    r := input.planned_values.root_module.resources[_]
    r.type == vars.resource_type
]

total := count(resources)

# count non-compliant ones
non_compliant := count([
  r |
    r := resources[_]
    r.values.location != compliant_location
])

# now summary is just the two-element array you want
summary := [
  sprintf("Total %s detected: %d",      [vars.friendly_resource_name, total]),
  sprintf("Non-compliant %s: %d/%d",    [vars.friendly_resource_name, non_compliant, total])
]
