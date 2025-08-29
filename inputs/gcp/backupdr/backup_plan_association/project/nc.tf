# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_backup_dr_backup_plan_association" "nc" {
  location                    = "australia-southeast1"
  resource_type               = "compute.googleapis.com/Instance"
  backup_plan_association_id = "invalid-bpa-project"
  resource                   = "projects/unknown-project/zones/australia-southeast1-a/instances/my-instance"
  backup_plan                = "backup-plan-project-bad"
  project                    = "unknown-project"  # Disallowed project
}
