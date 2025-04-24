# Describe the google_backup_dr_data_source data source.
# Keep "nc" as the name to indicate that this configuration is non-compliant.
resource "google_backup_dr_backup_vault" "unapproved_vault" {
  location                                   = "australia-southeast1"
  backup_vault_id                            = "unapproved-vault"
  backup_minimum_enforced_retention_duration = "1d"
}

data "google_backup_dr_data_source" "nc" {
  project         = "policy-deployment-backups"
  location        = "australia-southeast1"
  backup_vault_id = google_backup_dr_backup_vault.unapproved_vault.id
  data_source_id  = "valid-data-source-id"
}
