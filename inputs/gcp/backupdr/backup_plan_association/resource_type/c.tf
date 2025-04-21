# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_backup_dr_backup_plan_association" "c" {
  location                    = "australia-southeast1"
  resource_type               = "compute.googleapis.com/Instance"  # Valid resource type
  backup_plan_association_id = "valid-bpa-type"
  resource                   = "projects/my-project-id/zones/australia-southeast1-a/instances/instance-1"
  backup_plan                = "valid-backup-plan"
}
