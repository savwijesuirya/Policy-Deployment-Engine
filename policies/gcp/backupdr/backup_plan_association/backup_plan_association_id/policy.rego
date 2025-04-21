package terraform.gcp.security.backupdr.backup_plan_association.backup_plan_association_id

import data.terraform.gcp.security.backupdr.backup_plan_association.vars

attribute_path := "backup_plan_association_id"
regex_pattern := "^[a-z0-9-]+$"

all_resources := [
  r |
    r := input.planned_values.root_module.resources[_];
    r.type == vars.resource_type
]

violations := [
  sprintf(
    "%s '%s' has invalid %s: '%s'",
    [
      vars.friendly_resource_name,
      r.name,
      replace(attribute_path, "_", " "),
      r.values[attribute_path]
    ]
  ) |
  r := all_resources[_];
  not regex.match(regex_pattern, r.values[attribute_path])
]

lines := array.concat(
  [
    sprintf("Total %s detected: %d", [vars.friendly_resource_name, count(all_resources)]),
    sprintf("Non-compliant %s: %d/%d", [vars.friendly_resource_name, count(violations), count(all_resources)])
  ],
  violations
)

# expose it under `message` if you need .message
summary := {"message": lines}
