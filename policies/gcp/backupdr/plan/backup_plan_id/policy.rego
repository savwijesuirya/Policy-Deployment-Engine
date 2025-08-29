package terraform.gcp.security.backupdr.backup_plan.backup_plan_id

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

# Relative to each resource, helpers auto-start inside .values
attribute_path := ["backup_plan_id"]

# Only this ID is allowed
approved_ids := ["compliant-plan-id"]

conditions := [
  [
    {
      "situation_description": "Backup Plan ID must match the approved plan ID",
      "remedies": [
        "Set `backup_plan_id` to `compliant-plan-id`"
      ]
    },
    {
      "condition":      "backup_plan_id not in approved list",
      "attribute_path": attribute_path,
      "values":         approved_ids,
      "policy_type":    "whitelist"
    }
  ]
]

# Override so errors report against the actual ID field
policy_vars := {
  "friendly_resource_name": vars.variables.friendly_resource_name,
  "resource_type":          vars.variables.resource_type,
  "resource_value_name":    "backup_plan_id",
}

message := helpers.get_multi_summary(conditions, policy_vars).message
details := helpers.get_multi_summary(conditions, policy_vars).details
