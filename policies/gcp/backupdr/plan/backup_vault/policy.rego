package terraform.gcp.security.backupdr.backup_plan.backup_vault

import data.terraform.gcp.security.backupdr.backup_plan.vars

compliant_vaults := {
  "projects/policy-deployment-backups/locations/australia-southeast1/backupVaults/approved-vault"
}

resources := [
  r |
    r := input.planned_values.root_module.resources[_]
    r.type == vars.resource_type
]

total := count(resources)

violations := [
  sprintf("%s '%s' uses unapproved backup vault: '%s'",
    [vars.friendly_resource_name, r.name, r.values.backup_vault])
  |
    r := resources[_]
    not compliant_vaults[r.values.backup_vault]
]

non_compliant := count(violations)

summary := {
  "message": [
    sprintf("Total %s detected: %d",   [vars.friendly_resource_name, total]),
    sprintf("Non-compliant %s: %d/%d", [vars.friendly_resource_name, non_compliant, total])
  ],
 
  "total": total,
  "non_compliant": non_compliant,
  "violations": violations
}