# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_backup_dr_backup_vault" "c" {
  provider                                = google
  backup_vault_id                         = "c"
  location                                = "australia-southeast1"
  backup_minimum_enforced_retention_duration = "86400s"
  ignore_inactive_datasources             = true
}