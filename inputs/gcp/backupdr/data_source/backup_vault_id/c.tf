# Describe the google_backup_dr_data_source data source.
# Keep "c" as the name to indicate that this configuration is compliant.
resource "google_backup_dr_backup_vault" "approved_vault" {
  location                                   = "australia-southeast1"
  backup_vault_id                            = "approved-vault"
  backup_minimum_enforced_retention_duration = "1d"
}

data "google_backup_dr_data_source" "c" {
  project         = "policy-deployment-backups"
  location        = "australia-southeast1"
  backup_vault_id = google_backup_dr_backup_vault.approved_vault.id
  data_source_id  = "valid-data-source-id"
}
