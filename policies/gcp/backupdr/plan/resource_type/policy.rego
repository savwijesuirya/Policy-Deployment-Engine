package terraform.gcp.security.backupdr.backup_plan.resource_type

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

attribute_path := "resource_type"

compliant_values := [
  "GCE_VM"
]

summary := {
  "message": evaluation_message,
}

evaluation_message := array.concat(resource_summary, violations) if {
  resources := input.planned_values.root_module.resources
  relevant_resources := [r | r := resources[_]; r.type == vars.resource_type]

  violations := [
    sprintf(
      "%s '%s' has unapproved %s: '%s'",
      [
        vars.friendly_resource_name,
        r.name,
        replace(attribute_path, "_", " "),
        object.get(r.values, attribute_path, "")
      ]
    ) |
    r := relevant_resources[_]
    not helpers.array_contains(compliant_values, object.get(r.values, attribute_path, ""))
  ]

  compliant_resources := [
    r |
    r := relevant_resources[_]
    helpers.array_contains(compliant_values, object.get(r.values, attribute_path, ""))
  ]

  resource_summary := [
    sprintf("Total %s detected: %d", [vars.friendly_resource_name, count(relevant_resources)]),
    sprintf("Compliant %s: %d/%d", [vars.friendly_resource_name, count(compliant_resources), count(relevant_resources)]),
    sprintf("Non-compliant %s: %d/%d", [vars.friendly_resource_name, count(violations), count(relevant_resources)])
  ]
}
