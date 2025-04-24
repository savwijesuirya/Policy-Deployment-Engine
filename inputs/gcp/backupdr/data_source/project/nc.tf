# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

data "google_backup_dr_data_source" "nc" {
  project         = "unknown-project"                               
  location        = "australia-southeast1"
  backup_vault_id = google_backup_dr_backup_vault.approved_vault.id
  data_source_id  = "valid-data-source-id"
}
