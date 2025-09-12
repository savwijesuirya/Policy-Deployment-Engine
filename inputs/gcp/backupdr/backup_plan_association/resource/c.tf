# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_backup_dr_backup_plan_association" "c" {
  location                    = "australia-southeast1"
  resource_type               = "compute.googleapis.com/Instance"
  backup_plan_association_id = "valid-bpa-resource"
  resource                   = "projects/policy-deployment-backups/zones/australia-southeast1-a/instances/valid"
  backup_plan                = "valid-backup-plan"
}
