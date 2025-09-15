# Define a non-compliant google_backup_dr_backup_vault resource
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_backup_dr_backup_vault" "nc" {
  location        = "australia-southeast1"
  backup_vault_id = "nc"

  access_restriction = "UNRESTRICTED"

  backup_minimum_enforced_retention_duration = "3600s"

  labels = {
    "goog-terraform-provisioned" = "true"
  }
}
