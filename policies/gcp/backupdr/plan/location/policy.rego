package terraform.gcp.security.backupdr.backup_plan.location

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

# Report violations against the location value itself
vars_override := {
    "friendly_resource_name": vars.variables.friendly_resource_name,
    "resource_type":          vars.variables.resource_type,
    "resource_value_name":    "location",
}

conditions := [
  [
    {
      "situation_description": "Backup Plan must be created in the approved region",
      "remedies": [
        "Set `location` to `australia-southeast1`"
      ]
    },
    {
      "condition":      "location not in approved list",
      # Drill directly into the `location` field
      "attribute_path": ["location"],
      "values":         ["australia-southeast1"],
      "policy_type":    "whitelist"
    }
  ]
]

# General compliance summary
message := helpers.get_multi_summary(conditions, vars_override).message

# Detailed per-resource compliance
details := helpers.get_multi_summary(conditions, vars_override).details
