package terraform.gcp.security.backupdr.management_server.name

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.management_server.vars

attribute_path := "name"

# Only lowercase letters, digits and dashes allowed
regex_pattern := "^[a-z0-9-]+$"

# Gathering all the values that match our approved pattern
compliant_values := [
  v |
    r := input.planned_values.root_module.resources[_]
    r.type == vars.resource_type
    v := r.values[attribute_path]
    regex.match(regex_pattern, v)
]

summary := helpers.get_summary(
  vars.resource_type,
  attribute_path,
  compliant_values,
  vars.friendly_resource_name,
)
