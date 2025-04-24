package terraform.gcp.security.backupdr.data_source.data_source_id
import data.terraform.gcp.security.backupdr.data_source.vars
attribute_path := "data_source_id"
approved := {"valid-data-source-id"}
resources := [
    r |
    r := input.planned_values.root_module.resources[_]
    r.type == vars.resource_type
]
total_count := count(resources)
non_compliant_count := count([
    r |
    r := resources[_]
    not approved[r.values[attribute_path]]
])
summary := {
    "message": [
        sprintf("Total %s detected: %d", [vars.friendly_resource_name, total_count]),
        sprintf("Non-compliant %s: %d/%d", [vars.friendly_resource_name, non_compliant_count, total_count])
    ]
}
