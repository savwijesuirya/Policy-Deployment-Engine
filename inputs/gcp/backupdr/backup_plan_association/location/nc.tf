# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_backup_dr_backup_plan_association" "nc" {
  location                    = "us-west1"  # Not an approved location
  resource_type               = "compute.googleapis.com/Instance"
  backup_plan_association_id = "invalid-bpa-location"
  resource                   = "projects/my-project-id/zones/us-west1-a/instances/my-instance"
  backup_plan                = "backup-plan-location-bad"
  project                    = "my-project-id"
}
