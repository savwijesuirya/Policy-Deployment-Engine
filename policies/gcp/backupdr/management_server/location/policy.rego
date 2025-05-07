package terraform.gcp.security.backupdr.management_server.location

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.management_server.vars

# attribute we’re checking
attribute_path := "location"

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
      "attribute_path": attribute_path,
      "values":         ["australia-southeast1"],
      "policy_type":    "whitelist"
    }
  ]
]

# build a local vars map that uses the actual location value as the “name”
policy_vars := {
  "friendly_resource_name": vars.variables.friendly_resource_name,
  "resource_type":          vars.variables.resource_type,
  "resource_value_name":    attribute_path
}

# final outputs
message := helpers.get_multi_summary(conditions, policy_vars).message
details := helpers.get_multi_summary(conditions, policy_vars).details
