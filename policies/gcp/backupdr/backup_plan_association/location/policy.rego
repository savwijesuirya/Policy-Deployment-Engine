package terraform.gcp.security.backupdr.backup_plan_association.location

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan_association.vars

# Field to validate
attribute_path := "location"

# Only allow this approved region
valid_location := "australia-southeast1"

# Grab all of our BackupPlanAssociation resources
all_assocs := helpers.get_all_resources(vars.resource_type)

# Find the ones that violate our approved location rule
violations := [
    sprintf(
      "%s '%s' uses unapproved %s: '%s'",
      [ vars.friendly_resource_name
      , r.name
      , attribute_path
      , object.get(r.values, attribute_path, "<missing>")
      ]
    ) |
    r := all_assocs[_]
    object.get(r.values, attribute_path, "") != valid_location
]

# Build the top‑line counts
counts := [
    sprintf("Total %s detected: %d", [vars.friendly_resource_name, count(all_assocs)]),
    sprintf("Non-compliant %s: %d/%d", [vars.friendly_resource_name, count(violations), count(all_assocs)])
]

# Final summary map with a `.message` array
summary := {
  "message": array.concat(counts, violations)
}
