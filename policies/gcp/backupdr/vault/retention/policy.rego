package terraform.gcp.security.backupdr.backup_vault.retention
import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_vault.vars

conditions := [
  [
    {
      "situation_description": "Use unapproved retention time ",
      "remedies": [
        "Set `retention` to 86400s"
      ]
    },
    {
      "condition":      "retention time is not in approved list ",
      "attribute_path": "retention",
      "values":         ["86400s"],
      "policy_type":    "whitelist"
    }
  ]
]

# final outputs
message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details
