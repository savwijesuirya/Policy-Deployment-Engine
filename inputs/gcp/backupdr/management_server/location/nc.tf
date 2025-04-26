# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_backup_dr_management_server" "nc" {
  # Disallowed location
  location = "europe-west1"

  # Required arguments you’ll already have in your real config:
  name = "ms-console"
  type = "BACKUP_RESTORE"
}
