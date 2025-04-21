package terraform.gcp.security.backupdr.backup_plan_association.resource

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan_association.vars

# Field to validate
attribute_path := "resource"

# Only allowed prefix
valid_prefix := "projects/my-project-id/zones/australia-southeast1-a/instances/"

# Gather all BackupPlanAssociation resources
all_assocs := helpers.get_all_resources(vars.resource_type)

# Find the ones that don't start with the valid prefix
violations := [
    sprintf(
      "%s '%s' has invalid %s: '%s'",
      [
        vars.friendly_resource_name,
        r.name,
        attribute_path,
        object.get(r.values, attribute_path, "<missing>")
      ]
    ) |
    r := all_assocs[_]
    not startswith(object.get(r.values, attribute_path, ""), valid_prefix)
]

# Build the summary messages
base := [
  sprintf("Total %s detected: %d", [vars.friendly_resource_name, count(all_assocs)]),
  sprintf("Non-compliant %s: %d/%d", [vars.friendly_resource_name, count(violations), count(all_assocs)])
]

summary := {
  "message": array.concat(base, violations)
}
