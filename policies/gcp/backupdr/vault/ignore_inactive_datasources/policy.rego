package terraform.gcp.security.backupdr.backup_vault.ignore_inactive_datasources
import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_vault.vars

conditions := [
  [
    {
      "situation_description": "Use unapproved ignore_inactive_datasources",
      "remedies": [
        "Set `ignore_inactive_datasources` to true "
      ]
    },
    {
      "condition":      "ignore_inactive_datasources not in approved list ",
      "attribute_path": "ignore_inactive_datasources",
      "values":         ["true"],
      "policy_type":    "whitelist"
    }
  ]
]

# final outputs
message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details
