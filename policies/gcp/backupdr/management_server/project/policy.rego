package terraform.gcp.security.backupdr.management_server.project

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.management_server.vars

# Override so the violation “name” comes from the project field
vars_override := {
    "friendly_resource_name": vars.variables.friendly_resource_name,
    "resource_type":         vars.variables.resource_type,
    "resource_value_name":   "project",
}

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
      "attribute_path": ["project"],                   # ← just the key inside resource.values
      "values":         ["policy-deployment-backups"],
      "policy_type":    "whitelist"
    }
  ]
]

# Generate the summary & details using our override
message := helpers.get_multi_summary(conditions, vars_override).message
details := helpers.get_multi_summary(conditions, vars_override).details
