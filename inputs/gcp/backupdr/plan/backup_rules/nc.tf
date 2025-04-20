# Describe the google_backup_dr_backup_plan resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_backup_dr_backup_plan" "nc" {
  backup_plan_id = "plan-with-bad-rules"
  resource_type  = "GCE_VM"
  location       = "australia-southeast1"
  project        = "my-project-id"
  backup_vault   = "projects/my-project-id/locations/australia-southeast1/backupVaults/approved-vault"

  backup_rules {
    rule_id               = "daily-rule"
    backup_retention_days = 5    # too short to meet policy

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
