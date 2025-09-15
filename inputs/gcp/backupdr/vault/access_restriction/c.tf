resource "google_backup_dr_backup_vault" "c" {
  backup_vault_id = "c"
  location = "australia-southeast1"
  backup_minimum_enforced_retention_duration = "86400s"
  force_delete = true
  access_restriction = "WITHIN_ORGANIZATION"
  labels = {
    "goog-terraform-provisioned" = "true"
  }

}
