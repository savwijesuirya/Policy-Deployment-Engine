package terraform.gcp.security.backupdr.backup_plan.standard_schedule

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

attribute_path := "backup_rules"

compliant_values := "valid"

summary := {
  "message": evaluation_message,
}

evaluation_message := array.concat([
  sprintf("Total %s detected: %d", [vars.friendly_resource_name, count(relevant_resources)]),
  sprintf("Non-compliant %s: %d/%d", [vars.friendly_resource_name, count(violations), count(relevant_resources)])
], violations)

relevant_resources := [r | 
  r := input.planned_values.root_module.resources[_]
  r.type == vars.resource_type
]

violations := [msg |
  r := relevant_resources[_]
  rules := object.get(r.values, attribute_path, [])
  some i
  rule := rules[i]
  standard_schedules := object.get(rule, "standard_schedule", [])
  some j
  sched := standard_schedules[j]

  not is_valid_schedule(sched)

  msg := sprintf("%s '%s' has invalid standard_schedule config: recurrence_type='%s', time_zone='%s', backup_window='%v'", [
    vars.friendly_resource_name,
    r.name,
    sched.recurrence_type,
    sched.time_zone,
    object.get(sched, "backup_window", [])
  ])
]

is_valid_schedule(sched) if {
  sched.recurrence_type == "DAILY"
  sched.time_zone == "UTC"
  backup_window := object.get(sched, "backup_window", [])
  some w
  window := backup_window[w]
  start := window.start_hour_of_day
  end := window.end_hour_of_day
  start >= 0
  start < 24
  end > start
  end <= 24
}
