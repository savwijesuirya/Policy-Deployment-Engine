# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_backup_dr_management_server" "c" {
  location = "australia-southeast1"
  # Approved name
  name = "ms-console"
  type = "BACKUP_RESTORE"
}
