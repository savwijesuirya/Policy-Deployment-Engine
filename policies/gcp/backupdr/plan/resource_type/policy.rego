package terraform.gcp.security.backupdr.backup_plan.resource_type # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

conditions := [
  [
    {
      "situation_description": "Use unapproved resource type   ",
      "remedies": [
        "Set `resource type to ` to GCE_VM "
      ]
    },
    {
      "condition":      "location not in approved list ",
      "attribute_path": "resource_type",
      "values":         ["GCE_VM"],
      "policy_type":    "whitelist"
    }
  ]
]


# final outputs
message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details

 