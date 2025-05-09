# Describe the google_backup_dr_backup_plan resource type here
# This resource uses a non-compliant rule_id

resource "google_backup_dr_backup_plan" "nc" {
  backup_plan_id = "location-test-plan"
  resource_type  = "GCE_VM"
  location       = "australia-southeast1"
  project        = "policy-deployment-backups"
  backup_vault   = "projects/policy-deployment-backups/locations/australia-southeast1/backupVaults/approved-vault"

  backup_rules {
    rule_id               = "INVALID_RULE_ID"   #  does not follow the approved naming convention
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
