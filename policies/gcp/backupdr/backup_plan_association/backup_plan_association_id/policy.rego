package terraform.gcp.security.backupdr.backup_plan_association.backup_plan_association_id

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan_association.vars

# Policy: Enforce use of approved backup_plan_association_id values.
# This helps ensure that backup associations are predictable, secure, and traceable.

conditions := [
  [
    {
      "situation_description": "The `backup_plan_association_id` must be a valid, pre-approved identifier.",
      "remedies": [
        "Use one of the approved values such as `c`",
        "Avoid using special characters or untracked identifiers"
      ]
    },
    {
      "condition":      "`backup_plan_association_id` is not in the approved list",
      "attribute_path": ["backup_plan_association_id"],
      "values":         ["c"],  # Add more approved IDs as needed
      "policy_type":    "whitelist"
    }
  ]
]

# Policy Outputs
message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details
