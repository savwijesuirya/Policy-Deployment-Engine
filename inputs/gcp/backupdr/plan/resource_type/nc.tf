# Improper resource declaration or invalid type
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_backup_dr_backup_plan" "nc" {
  backup_plan_id = "nc"
  resource_type  = "INVALID_TYPE" # Improper or unsupported type
  location       = "australia-southeast1"
  project        = "policy-deployment-backups"
  backup_vault   = "projects/policy-deployment-backups/locations/australia-southeast1/backupVaults/unapproved-vault"

  backup_rules {
    rule_id               = "rule-1"
    backup_retention_days = 5 # Too low

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
