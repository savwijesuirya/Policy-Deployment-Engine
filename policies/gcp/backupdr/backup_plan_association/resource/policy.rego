package terraform.gcp.security.backupdr.backup_plan_association.resource
import data.terraform.gcp.security.backupdr.backup_plan_association.vars
attribute_path := "resource"
valid_prefix := "projects/policy-deployment-backups/zones/australia-southeast1-a/instances/"
resources := [
    r |
    r := input.planned_values.root_module.resources[_]
    r.type == vars.resource_type
]
total_count := count(resources)
non_compliant_count := count([
    r |
    r := resources[_]
    not startswith(r.values[attribute_path], valid_prefix)
])
summary := {
    "message": [
        sprintf("Total %s detected: %d", [vars.friendly_resource_name, total_count]),
        sprintf("Non-compliant %s: %d/%d", [vars.friendly_resource_name, non_compliant_count, total_count])
    ]
}
