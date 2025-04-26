package terraform.gcp.security.backupdr.management_server.networks

import data.terraform.gcp.security.backupdr.management_server.vars

servers := [
  r |
  r := input.planned_values.root_module.resources[_]
  r.type == vars.resource_type
]

total := count(servers)

non_compliant_servers := { r.name |
  r := servers[_]
  prefix := sprintf("projects/%v/global/networks/", [r.values.project])
  some i
  n := r.values.networks[i]
  not startswith(n.network, prefix)
}

non_count := count(non_compliant_servers)

summary := {
  "message": [
    sprintf("Total %v detected: %v", [vars.friendly_resource_name, total]),
    sprintf("Non-compliant %v: %v/%v", [vars.friendly_resource_name, non_count, total])
  ]
}
