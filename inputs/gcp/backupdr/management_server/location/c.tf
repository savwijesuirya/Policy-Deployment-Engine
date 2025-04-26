# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_backup_dr_management_server" "c" {
  # Approved location
  location = "australia-southeast1"

  # Required arguments you’ll already have in your real config:
  name = "ms-console"
  type = "BACKUP_RESTORE"
}
