# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_backup_dr_backup_plan_association" "nc" {
  location                    = "us-central1"                      # Non-approved location
  resource_type               = "compute.googleapis.com/Instance"
  backup_plan_association_id = "invalid id!"                      # Invalid: contains space and special character
  resource                   = "projects/my-project-id/zones/us-central1-a/instances/invalid-instance"
  backup_plan                = "backup-plan-noncompliant"
  project                    = "my-project-id"
}
