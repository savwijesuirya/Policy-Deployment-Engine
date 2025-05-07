package terraform.gcp.security.backupdr.vault.ignore_inactive_datasources

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.vault.vars

# Override so violations report by backup_vault_id
vars_override := {
    "friendly_resource_name": vars.variables.friendly_resource_name,
    "resource_type":         vars.variables.resource_type,
    "resource_value_name":   "backup_vault_id",
}

conditions := [
  [
    {
      "situation_description": "Backup Vault must ignore inactive datasources",
      "remedies": [
        "Set `ignore_inactive_datasources` to `true`"
      ]
    },
    {
      "condition":      "ignore_inactive_datasources not true",
      # point directly at the field under values
      "attribute_path": ["ignore_inactive_datasources"],
      "values":         [true],
      "policy_type":    "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars_override).message
details := helpers.get_multi_summary(conditions, vars_override).details
