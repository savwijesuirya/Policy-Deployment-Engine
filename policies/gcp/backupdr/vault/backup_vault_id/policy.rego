package terraform.gcp.security.backupdr.vault.backup_vault_id

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.vault.vars

# Override so that violations report the actual backup_vault_id value
vars_override := {
    "friendly_resource_name": vars.variables.friendly_resource_name,
    "resource_type":         vars.variables.resource_type,
    "resource_value_name":   "backup_vault_id",
}

conditions := [
  [
    {
      "situation_description": "Backup Vault ID must be `backup-vault-c`",
      "remedies": [
        "Set `backup_vault_id` to `backup-vault-c`"
      ]
    },
    {
      "condition":      "backup_vault_id not in approved list",
      "attribute_path": ["backup_vault_id"],
      "values":         ["backup-vault-c"],
      "policy_type":    "whitelist"
    }
  ]
]

# Use our override so that the helper reports by the backup_vault_id value
message := helpers.get_multi_summary(conditions, vars_override).message
details := helpers.get_multi_summary(conditions, vars_override).details
