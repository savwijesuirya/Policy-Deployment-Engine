package terraform.gcp.security.backupdr.vault.access_restriction

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.vault.vars

attribute_path := "access_restriction"
compliant_values := ["WITHIN_ORGANIZATION"]

resources := [r | r := input.planned_values.root_module.resources[_]; r.type == vars.resource_type]
non_compliant := [r | r := resources[_]; r.values[attribute_path] != "WITHIN_ORGANIZATION"]

summary := {
  "message": array.concat([
    sprintf("Total GCP Backup Vault detected: %d", [count(resources)]),
    sprintf("Non-compliant GCP Backup Vault: %d/%d", [count(non_compliant), count(resources)])
  ], [sprintf("GCP Backup Vault '%s' has non-compliant access_restriction: '%s'", [r.values.backup_vault_id, r.values[attribute_path]]) | r := non_compliant[_]])
}
