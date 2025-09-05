package terraform.gcp.security.backupdr.backup_plan_association.resource

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan_association.vars

conditions := [
  [
    {
      "situation_description": "Resource must reference the approved GCE instance",
      "remedies": [
        "Use the exact instance path from the plan JSON"
      ]
    },
    {
      "condition":      "resource not in approved list",
      # look directly at resource.values.resource
      "attribute_path": ["resource"],
      "values":         ["projects/policy-deployment-backups/zones/australia-southeast1-a/instances/instance-1"],
      "policy_type":    "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details