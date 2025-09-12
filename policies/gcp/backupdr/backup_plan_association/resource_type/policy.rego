package terraform.gcp.security.backupdr.backup_plan_association.resource_type

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan_association.vars


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
      "values":         ["compute.googleapis.com/valid"],
      "policy_type":    "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details
