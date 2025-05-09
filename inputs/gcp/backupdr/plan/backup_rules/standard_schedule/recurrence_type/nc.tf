resource "google_backup_dr_backup_plan" "nc" {
  backup_plan_id = "location-test-plan"
  resource_type  = "GCE_VM"
  location       = "australia-southeast1"
  project        = "policy-deployment-backups"
  backup_vault   = "projects/policy-deployment-backups/locations/australia-southeast1/backupVaults/approved-vault"

  backup_rules {
    rule_id               = "rule-location"
    backup_retention_days = 30

    standard_schedule {
      recurrence_type   = "HOURLY"      #  valid Terraform, but non-compliant per our policy
      hourly_frequency  = 1             # required when using HOURLY
      time_zone         = "UTC"

      backup_window {
        start_hour_of_day = 0
        end_hour_of_day   = 23
      }
    }
  }
}
