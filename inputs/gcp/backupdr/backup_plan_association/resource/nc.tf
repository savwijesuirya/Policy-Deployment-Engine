# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_backup_dr_backup_plan_association" "nc" {
  location                    = "australia-southeast1"
  resource_type               = "compute.googleapis.com/Instance"
  backup_plan_association_id = "nc"
  resource                   = "invalid-format-resource-name"  # Improper resource format
  backup_plan                = "invalid-backup-plan"
}
