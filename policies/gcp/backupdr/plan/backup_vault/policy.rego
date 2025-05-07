package terraform.gcp.security.backupdr.backup_plan.backup_vault

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

# Override to report violations by the actual backup_vault value
vars_override := {
    "friendly_resource_name": vars.variables.friendly_resource_name,
    "resource_type":          vars.variables.resource_type,
    "resource_value_name":    "backup_vault",
}

conditions := [
  [
    {
      "situation_description": "Backup Plan must reference the approved vault",
      "remedies": [
        "Set `backup_vault` to `projects/policy-deployment-backups/locations/australia-southeast1/backupVaults/approved-vault`"
      ]
    },
    {
      "condition":      "backup_vault not in approved list",
      # Look directly at the `backup_vault` field
      "attribute_path": ["backup_vault"],
      "values":         [
        "projects/policy-deployment-backups/locations/australia-southeast1/backupVaults/approved-vault"
      ],
      "policy_type":    "whitelist"
    }
  ]
]

# General compliance summary
message := helpers.get_multi_summary(conditions, vars_override).message

# Detailed per-resource compliance
details := helpers.get_multi_summary(conditions, vars_override).details
