package terraform.gcp.security.backupdr.backup_plan.recurrence_type

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

# Tell the helper we’re reporting on recurrence_type
vars_override := {
    "friendly_resource_name": vars.variables.friendly_resource_name,
    "resource_type":          vars.variables.resource_type,
    "resource_value_name":    "backup_plan_id",
}

conditions := [
  [
    {
      "situation_description": "Standard schedule `recurrence_type` must be DAILY",
      "remedies": [
        "Set `backup_rules[*].standard_schedule[*].recurrence_type` to `DAILY`"
      ]
    },
    {
      "condition":      "Incorrect recurrence_type for standard_schedule",
      "attribute_path": ["backup_rules", "*", "standard_schedule", "*", "recurrence_type"],
      "values":         ["DAILY"],
      "policy_type":    "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars_override).message
details := helpers.get_multi_summary(conditions, vars_override).details
