package terraform.gcp.security.backupdr.data_source.backup_vault_id
vars := {
  "resource_type":          "google_backup_dr_data_source",
  "friendly_resource_name": "GCP Backup DR Data Source",
  "vault_type":             "google_backup_dr_backup_vault",
  "approved_vault_id":      "approved-vault",
}
approved_vault_addresses := {
  rv.address |
    rv := input.configuration.root_module.resources[_]
    rv.type == vars.vault_type
    rv.expressions.backup_vault_id.constant_value == vars.approved_vault_id
}
data_sources := [
  ds |
    ds := input.configuration.root_module.resources[_]
    ds.type == vars.resource_type
]
compliant_data_sources := {
  ds.address |
    ds := data_sources[_]
    some i
    raw_ref    := ds.expressions.backup_vault_id.references[i]
    vault_addr := replace(raw_ref, ".id", "")  # remove trailing ".id" if present
    approved_vault_addresses[vault_addr]
}
non_compliant_data_sources := {
  ds.address |
    ds := data_sources[_]
    not compliant_data_sources[ds.address]
}
summary := {
  "message": [
    sprintf("Total %s detected: %d", [
      vars.friendly_resource_name,
      count(data_sources)
    ]),
    sprintf("Non-compliant %s: %d/%d", [
      vars.friendly_resource_name,
      count(non_compliant_data_sources),
      count(data_sources)
    ])
  ]
}
