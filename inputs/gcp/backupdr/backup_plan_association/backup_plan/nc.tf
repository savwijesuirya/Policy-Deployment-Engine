# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_backup_dr_backup_plan_association" "nc" {
  location                    = "australia-southeast1"
  resource_type               = "compute.googleapis.com/Instance"
  backup_plan_association_id = "invalid-backup-plan-assoc"
  resource                   = "projects/my-project-id/zones/australia-southeast1-a/instances/instance-1"
  backup_plan                = ""  # Missing or invalid backup plan
}
