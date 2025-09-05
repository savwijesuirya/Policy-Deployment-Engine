package terraform.gcp.security.backupdr.management_server.location

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.management_server.vars


# only this region is allowed
conditions := [
  [
    {
      "situation_description": "Location must be the designated region",
      "remedies": [
        "Set `location` to `australia-southeast1`"
      ]
    },
    {
      "condition":      "location not in approved list",
      "attribute_path": "location",
      "values":         ["australia-southeast1"],
      "policy_type":    "whitelist"
    }
  ]
]


# final outputs
message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details
