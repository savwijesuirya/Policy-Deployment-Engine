# policies/gcp/backupdr/backup_plan_association/resource_type/policy.rego
package terraform.gcp.security.backupdr.backup_plan_association.resource_type

import data.terraform.gcp.security.backupdr.backup_plan_association.vars

# The field we’re checking
attribute_path := "resource_type"

# Only these GCP types are allowed
allowed := {"compute.googleapis.com/Instance", "storage.googleapis.com/Bucket"}

# Grab all BackupPlanAssociation resources
assoc := [
  r |
    r := input.planned_values.root_module.resources[_]
    r.type == vars.resource_type
]

# Find the ones that aren’t allowed
violations := [
  sprintf(
    "%s '%s' uses unapproved %s: '%s'",
    [
      vars.friendly_resource_name,
      r.name,
      replace(attribute_path, "_", " "),
      r.values.resource_type
    ]
  )
  | r := assoc[_]
  not allowed[r.values.resource_type]
]

# Total and non‑compliant counts
total := count(assoc)
nc    := count(violations)

# Build the same-summary shape the helper uses
summary := {
  "message": array.concat(
    [
      sprintf("Total %s detected: %d", [vars.friendly_resource_name, total]),
      sprintf("Non-compliant %s: %d/%d", [vars.friendly_resource_name, nc, total])
    ],
    violations
  )
}
