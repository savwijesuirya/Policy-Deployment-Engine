package terraform.gcp.security.backupdr.backup_plan_association.location

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan_association.vars

# Report violations by the location string itself

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
      # Look up resource.values.location directly
      "attribute_path": "location",
      "values":         ["australia-southeast1"],
      "policy_type":    "whitelist"
    }
  ]
]


message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details
