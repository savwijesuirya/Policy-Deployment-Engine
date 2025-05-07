package terraform.gcp.security.backupdr.backup_plan.backup_plan_id

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

# STEP 1: STUDY YOUR RESOURCE AND ITS ATTRIBUTES, THEN FILL IN THE VARS FILE

# The path to the backup_plan_id attribute in the Terraform state
attribute_path := ["values", "backup_plan_id"]

# Only this backup plan ID is allowed
approved_plan_ids := ["compliant-plan-id"]

# STEP 2: CREATE SCENARIOS
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
      "values":         approved_plan_ids,
      "policy_type":    "whitelist"
    }
  ]
]

# Override vars so violations are reported against the actual backup_plan_id value
policy_vars := {
  "friendly_resource_name": vars.variables.friendly_resource_name,
  "resource_type":          vars.variables.resource_type,
  "resource_value_name":    "backup_plan_id",
}

# Final outputs
message := helpers.get_multi_summary(conditions, policy_vars).message
details := helpers.get_multi_summary(conditions, policy_vars).details
