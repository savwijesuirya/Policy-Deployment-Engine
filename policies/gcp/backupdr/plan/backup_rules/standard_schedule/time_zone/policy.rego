package terraform.gcp.security.backupdr.backup_plan.time_zone

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

# Report violations against the time_zone value directly
vars_override := {
    "friendly_resource_name": vars.variables.friendly_resource_name,
    "resource_type":          vars.variables.resource_type,
    "resource_value_name":    "backup_plan_id",
}

conditions := [
    [
        {
            "situation_description": "Backup Plan's standard schedule time_zone must be UTC",
            "remedies": [
                "Set `backup_rules[0].standard_schedule[0].time_zone` to `UTC`"
            ],
        },
        {
            "condition":      "Standard schedule time_zone is not UTC",
            # Drill directly into the time_zone field
            "attribute_path": ["backup_rules", "*", "standard_schedule", "*", "time_zone"],
            "values":         ["UTC"],
            "policy_type":    "whitelist",
        },
    ],
]

# General compliance summary
message := helpers.get_multi_summary(conditions, vars_override).message

# Detailed per-resource compliance
details := helpers.get_multi_summary(conditions, vars_override).details
