# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_backup_dr_backup_plan_association" "nc" {
  location                    = "us-west1"  # Not an approved location
  resource_type               = "compute.googleapis.com/Instance"
  backup_plan_association_id = "nc 1"                      # Invalid: contains space and special character
  resource                   = "projects/policy-deployment-backups/zones/us-central1-a/instances/invalid-instance"
  backup_plan                = "backup-plan-noncompliant"
  project                    = "policy-deployment-backups"
}
