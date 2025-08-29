# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_backup_dr_backup_plan_association" "c" {
  location                    = "australia-southeast1"
  resource_type               = "compute.googleapis.com/Instance"
  backup_plan_association_id = "valid-bpa"
  resource                   = "projects/policy-deployment-backups/zones/australia-southeast1-a/instances/my-instance"
  backup_plan                = "backup-plan-compliant"
  project                    = "policy-deployment-backups"
}
