package terraform.gcp.security.backupdr.backup_plan.rule_id

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

# Tell the helper to name each “resource” by its rule_id
vars_override := {
  "friendly_resource_name": vars.variables.friendly_resource_name,
  "resource_type":          vars.variables.resource_type,
  "resource_value_name":    "backup_plan_id",
  "resource_value_path":    ["backup_rules", 0, "rule_id"],
}

conditions := [
  [
    {
      "situation_description": "All backup_rules[].rule_id must match the pattern 'rule-<lowercase>'",
      "remedies": [
        "Rename `rule_id` to follow 'rule-<description>' using only lowercase letters"
      ]
    },
    {
      "condition":      "Invalid rule_id in backup_rules",
      "attribute_path": ["backup_rules",0, "rule_id"],
      "values":         ["rule-location"],          # whitelist only the allowed one
      "policy_type":    "whitelist"         
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars_override).message
details := helpers.get_multi_summary(conditions, vars_override).details
