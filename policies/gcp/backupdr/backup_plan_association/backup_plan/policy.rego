package terraform.gcp.security.backupdr.backup_plan_association.backup_plan

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan_association.vars

# Policy Conditions
conditions := [
  [
    {
      "situation_description": "The `backup_plan` must not be empty and must be an approved plan ID.",
      "remedies": [
        "Provide a non-empty `backup_plan`",
        "Set `backup_plan` to a value from the approved list (e.g., `valid-backup-plan`)."
      ]
    },
    {
      "condition": "c1: `backup_plan` not in approved list or empty",
      "attribute_path": ["backup_plan"],
      "values": ["valid-backup-plan"],
      "policy_type": "whitelist"
    }
  ]
]

# Policy Output
message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details
