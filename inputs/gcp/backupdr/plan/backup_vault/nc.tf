# Describe the google_backup_dr_backup_plan resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non‑compliant

resource "google_backup_dr_backup_plan" "nc" {
  # Required identifiers
  backup_plan_id = "vault-test-plan"
  resource_type  = "GCE_VM"
  location       = "australia-southeast1"
  project        = "my-project-id"

  # Non‑compliant vault
  backup_vault = "projects/my-project-id/locations/australia-southeast1/backupVaults/unapproved-vault"

  # Still must include a backup_rules block
  backup_rules {
    rule_id               = "rule-vault"
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
