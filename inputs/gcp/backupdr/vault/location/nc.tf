# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_backup_dr_backup_vault" "nc" {
  provider                                = google-beta
  backup_vault_id                         = "backup-vault-nc"
  location                                = "invalid-region-01"
  backup_minimum_enforced_retention_duration = "86400s"
  ignore_inactive_datasources             = true
}
