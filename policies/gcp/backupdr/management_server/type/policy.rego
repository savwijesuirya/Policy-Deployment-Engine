package terraform.gcp.security.backupdr.management_server.type

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.management_server.vars

attribute_path := "type"

approved_types := ["BACKUP_RESTORE"]

compliant_values := [
    v |
    r := input.planned_values.root_module.resources[_]
    r.type == vars.resource_type
    v := r.values[attribute_path]
    approved_types[_] == v
]

summary := helpers.get_summary(
    vars.resource_type,
    attribute_path,
    compliant_values,
    vars.friendly_resource_name,
)
