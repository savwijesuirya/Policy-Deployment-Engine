package terraform.gcp.security.backupdr.backup_plan_association.backup_plan_association_id

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan_association.vars

conditions := [
  [
    {
      "situation_description": "Backup Plan Association ID must match an approved ID",
      "remedies": [
        "Use one of the known valid backup plan association IDs"
      ]
    },
    {
      "condition":      "backup_plan_association_id not in approved list",
      "attribute_path": ["backup_plan_association_id"],
      "values":         ["valid-bpa"],
      "policy_type":    "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details
