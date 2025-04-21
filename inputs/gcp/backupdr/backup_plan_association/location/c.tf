# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_backup_dr_backup_plan_association" "c" {
  location                    = "australia-southeast1"  # Approved location
  resource_type               = "compute.googleapis.com/Instance"
  backup_plan_association_id = "valid-bpa-location"
  resource                   = "projects/my-project-id/zones/australia-southeast1-a/instances/my-instance"
  backup_plan                = "backup-plan-location-ok"
  project                    = "my-project-id"
}
