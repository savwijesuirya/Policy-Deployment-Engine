package terraform.gcp.security.backupdr.vault.retention

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.vault.vars

# Override so violations report the retention value itself
vars_override := {
    "friendly_resource_name": vars.variables.friendly_resource_name,
    "resource_type":         vars.variables.resource_type,
    "resource_value_name":   "backup_minimum_enforced_retention_duration",
}

conditions := [
  [
    {
      "situation_description": "Backup Vault minimum enforced retention duration must be 86400s",
      "remedies": [
        "Set `backup_minimum_enforced_retention_duration` to `86400s`"
      ]
    },
    {
      "condition":      "Incorrect retention duration",
      # look directly at resource.values.backup_minimum_enforced_retention_duration
      "attribute_path": ["backup_minimum_enforced_retention_duration"],
      "values":         ["86400s"],
      "policy_type":    "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars_override).message
details := helpers.get_multi_summary(conditions, vars_override).details
