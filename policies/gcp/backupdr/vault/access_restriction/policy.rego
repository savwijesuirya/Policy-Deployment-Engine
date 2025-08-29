package terraform.gcp.security.backupdr.vault.access_restriction

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.vault.vars

# Override so that violations report the actual access_restriction value
vars_override := {
    "friendly_resource_name": vars.variables.friendly_resource_name,
    "resource_type":         vars.variables.resource_type,
    "resource_value_name":   "access_restriction",
}

conditions := [
  [
    {
      "situation_description": "Backup Vault access restriction must be WITHIN_ORGANIZATION",
      "remedies": [
        "Set `access_restriction` to `WITHIN_ORGANIZATION`"
      ]
    },
    {
      "condition":      "access_restriction not in approved list",
      "attribute_path": ["access_restriction"],
      "values":         ["WITHIN_ORGANIZATION"],
      "policy_type":    "whitelist"
    }
  ]
]

# Use override to report by the attribute value rather than the resource name
message := helpers.get_multi_summary(conditions, vars_override).message
details := helpers.get_multi_summary(conditions, vars_override).details
