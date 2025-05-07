package terraform.gcp.security.backupdr.backup_plan.resource_type

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

# Report violations against the resource_type value itself
vars_override := {
    "friendly_resource_name": vars.variables.friendly_resource_name,
    "resource_type":          vars.variables.resource_type,
    "resource_value_name":    "resource_type",
}

conditions := [
  [
    {
      "situation_description": "Resource type must be GCE_VM",
      "remedies": [
        "Set `resource_type` to `GCE_VM`"
      ]
    },
    {
      "condition":      "resource_type not in approved list",
      "attribute_path": ["resource_type"],        # <-- drill directly into the field
      "values":         ["GCE_VM"],
      "policy_type":    "whitelist"
    }
  ]
]

# General compliance summary
message := helpers.get_multi_summary(conditions, vars_override).message

# Detailed per-resource compliance
details := helpers.get_multi_summary(conditions, vars_override).details
