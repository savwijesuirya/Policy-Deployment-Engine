package terraform.gcp.security.backupdr.backup_vault.backup_vault_id
import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_vault.vars

conditions := [
  [
    {
      "situation_description": "Use unapproved back up vault id",
      "remedies": [
        "Set `back up vault id ` to c "
      ]
    },
    {
      "condition":      "back up vault id not in approved list ",
      "attribute_path": "backup_vault_id",
      "values":         ["c"],
      "policy_type":    "whitelist"
    }
  ]
]

# final outputs
message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details
