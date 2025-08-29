package terraform.gcp.security.backupdr.management_server.name

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.management_server.vars

conditions := [
  [
    {
      "situation_description": "Name must consist only of lowercase letters, digits, and dashes",
      "remedies": [
        "Rename the management server to match the regex ^[a-z0-9-]+$"
      ]
    },
    {
      "condition":      "name is not compliant",
      "attribute_path": "name",
      "values":         ["ms-console"],
      "policy_type":    "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details
