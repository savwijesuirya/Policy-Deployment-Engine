package terraform.gcp.security.backupdr.backup_plan_association.backup_plan  # Edit here
import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan_association.vars

# STEP 1: STUDY YOUR RESOURCE AND ITS ATTRIBUTES, THEN FILL IN THE VARS FILE

# STEP 2: CREATE SCENARIOS
conditions := [
  [
    {
      "situation_description": "Backup Plan must be a known valid plan ID",
      "remedies": [
        "Set `backup_plan` to one of the approved plan IDs"
      ]
    },
    {
      "condition": "c1: backup_plan not in approved list",
      "attribute_path": ["backup_plan"],
      "values":         ["valid-backup-plan"],
      "policy_type":    "whitelist"
    }
  ]
]

# Displays a general message about policy compliance
message := helpers.get_multi_summary(conditions, vars.variables).message

# Displays detailed compliance info for each resource
details := helpers.get_multi_summary(conditions, vars.variables).details
