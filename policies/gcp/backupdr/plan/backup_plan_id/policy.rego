package terraform.gcp.security.backupdr.backup_plan.backup_plan_id # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

conditions := [
  [
    {
      "situation_description": "Use unapproved back up plan id ",
      "remedies": [
        "Set `back up id` to c "
      ]
    },
    {
      "condition":      "back up plan id not in approved list ",
      "attribute_path": "backup_plan_id",
      "values":         ["c"],
      "policy_type":    "whitelist"
    }
  ]
]


# final outputs
message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details

 