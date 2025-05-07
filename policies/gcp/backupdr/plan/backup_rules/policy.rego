package terraform.gcp.security.backupdr.backup_plan.backup_rules  # Edit here
import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

# STEP 1: STUDY YOUR RESOURCE AND ITS ATTRIBUTES, THEN FILL IN THE VARS FILE

# STEP 2: CREATE SCENARIOS
conditions := [
  [
    {
      "situation_description": "Each backup rule must have a retention period of 30 days",
      "remedies": [
        "Set `backup_retention_days` to 30 in each `backup_rules` block"
      ]
    },
    {
      "condition":      "backup_retention_days not equal 30",
      "attribute_path": ["values","backup_rules",0,"backup_retention_days"],
      "values":         [30],
      "policy_type":    "whitelist"
    }
  ]
]

# Displays a general message about policy compliance
message := helpers.get_multi_summary(conditions, vars.variables).message

# Displays a detailed summary of each resource’s compliance
details := helpers.get_multi_summary(conditions, vars.variables).details
