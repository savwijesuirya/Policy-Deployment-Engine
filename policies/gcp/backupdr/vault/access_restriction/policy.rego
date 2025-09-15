package terraform.gcp.security.backupdr.backup_vault.access_restriction
import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_vault.vars

conditions := [
  [
    {
      "situation_description": "Use unapproved access restriction   ",
      "remedies": [
        "Set `acess restriction` to WITHIN_ORGANIZATION"
      ]
    },
    {
      "condition":      "access restriction not in approved list ",
      "attribute_path": "access_restriction",
      "values":         ["WITHIN_ORGANIZATION"],
      "policy_type":    "whitelist"
    }
  ]
]

# final outputs
message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details
