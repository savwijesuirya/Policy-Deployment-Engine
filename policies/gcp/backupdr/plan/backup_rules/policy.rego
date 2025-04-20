package terraform.gcp.security.backupdr.backup_plan.backup_rules 

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

attribute_path := "backup_rules.backup_retention_days" # Edit here (eg., "storage_class")
compliant_values := [
    30,
]

non_compliant_plans[plan] if {
    plan := input.planned_values.root_module.resources[_]
    plan.type == vars.resource_type
    backup_rule := plan.values.backup_rules[_]
    not helpers.array_contains(compliant_values, backup_rule.backup_retention_days)
}

total_plans := count([
    plan |
    plan := input.planned_values.root_module.resources[_]
    plan.type == vars.resource_type
])

non_compliant_count := count(non_compliant_plans)

summary := {
    "message": [
        sprintf("Total GCP Backup DR Backup Plan detected: %v", [total_plans]),
        sprintf("Non-compliant GCP Backup DR Backup Plan: %v/%v", [non_compliant_count, total_plans]),
    ],
}