package terraform.gcp.security.backupdr.backup_plan_association.backup_plan_association_id
import data.terraform.gcp.security.backupdr.backup_plan_association.vars

attribute_path := "backup_plan_association_id"
regex_pattern := "^[a-z0-9-]+$"
resources := [
    r |
    r := input.planned_values.root_module.resources[_]
    r.type == vars.resource_type
]
total_count := count(resources)
non_compliant_count := count([
    r |
    r := resources[_]
    not regex.match(regex_pattern, r.values[attribute_path])
])
summary := {
    "message": [
        sprintf("Total %s detected: %d", [vars.friendly_resource_name, total_count]),
        sprintf("Non-compliant %s: %d/%d", [vars.friendly_resource_name, non_compliant_count, total_count])
    ]
}
