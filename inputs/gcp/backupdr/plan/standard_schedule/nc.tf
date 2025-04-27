# Non-compliant but Terraform-valid Backup Plan
resource "google_backup_dr_backup_plan" "nc" {
  backup_plan_id = "plan-with-bad-rules"
  resource_type  = "GCE_VM"
  location       = "australia-southeast1"
  project        = "policy-deployment-backups"
  backup_vault   = "projects/policy-deployment-backups/locations/australia-southeast1/backupVaults/unapproved-vault" # invalid vault

  backup_rules {
    rule_id               = "daily-rule"
    backup_retention_days = 3  # Too short to meet retention policy

    standard_schedule {
      recurrence_type = "DAILY"      # Valid but policy may expect WEEKLY or more
      time_zone       = "Mars/Zone"  # Invalid time zone format (will pass Terraform but be caught by policy)

      backup_window {
        start_hour_of_day = 22
        end_hour_of_day   = 21  # Invalid window (end < start)
      }
    }
  }
}
