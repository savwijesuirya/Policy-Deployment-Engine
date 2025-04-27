# Describe the google_backup_dr_backup_plan resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_backup_dr_backup_plan" "nc" {
  backup_plan_id = "INVALID_PLAN_ID"
  resource_type  = ""
  location       = "australia-southeast1"
  project        = "policy-deployment-backups"
  backup_vault   = "projects/policy-deployment-backups/locations/australia-southeast1/backupVaults/approved-vault"

  backup_rules {
    rule_id               = "rule-1"
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
