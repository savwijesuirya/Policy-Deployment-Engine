package terraform.gcp.security.backupdr.backup_plan.backup_vault # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

conditions := [
  [
    {
      "situation_description": "Use unapproved back up vault ",
      "remedies": [
        "Set `back up vault` to projects/policy-deployment-backups/locations/australia-southeast1/backupVaults/approved-vault "
      ]
    },
    {
      "condition":      "back up plan vault not in approved list ",
      "attribute_path": "backup_plan_vault",
      "values":         ["projects/policy-deployment-backups/locations/australia-southeast1/backupVaults/approved-vault"],
      "policy_type":    "whitelist"
    }
  ]
]


# final outputs
message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details

 