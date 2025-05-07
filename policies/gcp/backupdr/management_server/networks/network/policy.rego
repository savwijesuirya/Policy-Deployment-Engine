package terraform.gcp.security.backupdr.management_server.networks

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.management_server.vars


conditions := [
  [
    {
      "situation_description": "Network must be a VPC peering range under the project's global networks",
      "remedies": [
        "Use a network in the form `projects/policy-deployment-backups/global/networks/vpc-network`"
      ]
    },
    {
      "condition":      "network not in approved list",
      "attribute_path": ["networks", 0, "network"],
      "values":         [
         "projects/policy-deployment-backups/global/networks/vpc-network"
      ],
      "policy_type":    "whitelist"
    }
  ]
]

policy_vars := {
  "friendly_resource_name": vars.variables.friendly_resource_name,
  "resource_type":          vars.variables.resource_type,
  "resource_value_name":    "name" 
}

message := helpers.get_multi_summary(conditions, policy_vars).message
details := helpers.get_multi_summary(conditions, policy_vars).details
