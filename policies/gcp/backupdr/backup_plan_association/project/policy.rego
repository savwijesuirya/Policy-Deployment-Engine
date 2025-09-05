package terraform.gcp.security.backupdr.backup_plan_association.project

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan_association.vars


conditions := [
  [
    {
      "situation_description": "Project must match the deployment project",
      "remedies": [
        "Set `project` to `policy-deployment-backups`"
      ]
    },
    {
      "condition":      "project not in approved list",
      # look up resource.values.project directly
      "attribute_path": "project",
      "values":         ["policy-deployment-backups"],
      "policy_type":    "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details
