package terraform.gcp.security.backupdr.backup_plan.location # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

conditions := [
  [
    {
      "situation_description": "Use unapproved location  ",
      "remedies": [
        "Set `location` to australia-southeast1 "
      ]
    },
    {
      "condition":      "location not in approved list ",
      "attribute_path": ["location"],
      "values":         ["australia-southeast1"],
      "policy_type":    "whitelist"
    }
  ]
]


# final outputs
message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details

 