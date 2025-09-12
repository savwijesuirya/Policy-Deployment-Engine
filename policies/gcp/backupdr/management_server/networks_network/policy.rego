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

message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details



