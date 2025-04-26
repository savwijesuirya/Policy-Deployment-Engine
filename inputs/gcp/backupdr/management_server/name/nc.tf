# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_backup_dr_management_server" "nc" {
  location = "australia-southeast1"

  # Disallowed name
  name = "MS Console!"
  type = "BACKUP_RESTORE"
}