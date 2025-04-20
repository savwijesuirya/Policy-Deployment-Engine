# Describe the google_backup_dr_backup_plan resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_backup_dr_backup_plan" "c" {
  backup_plan_id = "location-test-plan"
  resource_type  = "GCE_VM"
  location       = "australia-southeast1"
  project        = "my-project-id"
  backup_vault   = "projects/my-project-id/locations/australia-southeast1/backupVaults/approved-vault"

  backup_rules {
    rule_id               = "rule-location"
    backup_retention_days = 30

    standard_schedule {
      recurrence_type = "DAILY"
      time_zone       = "UTC"

      backup_window {
        start_hour_of_day = 0
        end_hour_of_day   = 23
      }
    }
  }
}
