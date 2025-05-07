package terraform.gcp.security.backupdr.backup_plan.standard_schedule  # Edit here
import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

# STEP 1: STUDY YOUR RESOURCE AND ITS ATTRIBUTES, THEN FILL IN THE VARS FILE

# STEP 2: CREATE SCENARIOS (validate each standard_schedule block)
conditions := [

  # Recurrence type must be DAILY
  [
    {
      "situation_description": "Recurrence type must be DAILY",
      "remedies": [
        "Set `recurrence_type` to `DAILY` in each `backup_rules.standard_schedule` block"
      ]
    },
    {
      "condition":      "recurrence_type not DAILY",
      "attribute_path": ["values","backup_rules",0,"standard_schedule",0,"recurrence_type"],
      "values":         ["DAILY"],
      "policy_type":    "whitelist"
    }
  ],

  # Time zone must be UTC
  [
    {
      "situation_description": "Time zone must be UTC",
      "remedies": [
        "Set `time_zone` to `UTC` in each `backup_rules.standard_schedule` block"
      ]
    },
    {
      "condition":      "time_zone not UTC",
      "attribute_path": ["values","backup_rules",0,"standard_schedule",0,"time_zone"],
      "values":         ["UTC"],
      "policy_type":    "whitelist"
    }
  ]
]

# Displays a general message about policy compliance
message := helpers.get_multi_summary(conditions, vars.variables).message

# Displays a detailed summary of each resource’s compliance to every condition
details := helpers.get_multi_summary(conditions, vars.variables).details
