package terraform.gcp.security.backupdr.management_server.type  # Edit here
import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.management_server.vars

# STEP 1: STUDY YOUR RESOURCE AND ITS ATTRIBUTES, THEN FILL IN THE VARS FILE

# STEP 2: CREATE SCENARIOS
conditions := [
  [
    {
      "situation_description": "Type must be BACKUP_RESTORE",
      "remedies": [
        "Set `type` to `BACKUP_RESTORE`"
      ]
    },
    {
      "condition":      "type not in approved list",
      "attribute_path": ["values","type"],
      "values":         ["BACKUP_RESTORE"],
      "policy_type":    "whitelist"
    }
  ]
]

# Displays a general message about policy compliance
message := helpers.get_multi_summary(conditions, vars.variables).message

# Displays a detailed summary of each resource’s compliance
details := helpers.get_multi_summary(conditions, vars.variables).details
