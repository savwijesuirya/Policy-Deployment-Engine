package terraform.gcp.security.backupdr.backup_plan_association.resource_type

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan_association.vars

# Report violations by the raw resource_type value
vars_override := {
    "friendly_resource_name": vars.variables.friendly_resource_name,
    "resource_type":         vars.variables.resource_type,
    "resource_value_name":   "resource_type",
}

conditions := [
  [
    {
      "situation_description": "Resource type must match the expected GCE instance type",
      "remedies": [
        "Use `compute.googleapis.com/Instance` as the `resource_type`"
      ]
    },
    {
      "condition":      "resource_type not in approved list",
      # Look directly at the resource_type field
      "attribute_path": ["resource_type"],
      "values":         ["compute.googleapis.com/Instance"],
      "policy_type":    "whitelist"
    }
  ]
]

# Top-level summary message
message := helpers.get_multi_summary(conditions, vars_override).message

# Detailed per-resource output
details := helpers.get_multi_summary(conditions, vars_override).details
