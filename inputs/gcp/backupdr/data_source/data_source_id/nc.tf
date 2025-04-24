# Describe the google_backup_dr_data_source data source.
# Keep "nc" as the name to indicate that this configuration is non-compliant.

data "google_backup_dr_data_source" "nc" {
  project         = "policy-deployment-backups"
  location        = "australia-southeast1"
  backup_vault_id = google_backup_dr_backup_vault.approved_vault.id

  # Non-compliant: data_source_id contains invalid characters (spaces, uppercase, etc.)
  data_source_id  = "Invalid DataSource!"
}
