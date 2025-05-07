package terraform.gcp.security.backupdr.vault.location

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.vault.vars

# Override so violations report the actual location value
vars_override := {
    "friendly_resource_name": vars.variables.friendly_resource_name,
    "resource_type":         vars.variables.resource_type,
    "resource_value_name":   "location",
}

conditions := [
  [
    {
      "situation_description": "Backup Vault location must be one of the approved regions",
      "remedies": [
        "Set `location` to `australia-southeast1` or `AU`"
      ]
    },
    {
      "condition":      "location not in approved list",
      # ← look directly at resource.values.location
      "attribute_path": ["location"],
      "values":         ["australia-southeast1", "AU"],
      "policy_type":    "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars_override).message
details := helpers.get_multi_summary(conditions, vars_override).details
