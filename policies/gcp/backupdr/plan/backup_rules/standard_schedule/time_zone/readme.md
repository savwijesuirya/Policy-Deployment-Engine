# `time_zone` Attribute in `standard_schedule` for `google_backup_dr_backup_plan`

This README describes the compliance requirement for the `time_zone` attribute inside each `standard_schedule` block of the `backup_rules` in the `google_backup_dr_backup_plan` resource.

---

## Compliant Example (`c.tf`)

```hcl
resource "google_backup_dr_backup_plan" "c" {
  provider       = google
  location       = "australia-southeast1"
  backup_plan_id = "location-test-plan"
  resource_type  = "GCE_VM"
  backup_vault   = "projects/policy-deployment-backups/locations/australia-southeast1/backupVaults/approved-vault"

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
```

---

## Non-Compliant Example (`nc.tf`)

```hcl
resource "google_backup_dr_backup_plan" "nc" {
  provider       = google
  location       = "australia-southeast1"
  backup_plan_id = "location-test-plan"
  resource_type  = "GCE_VM"
  backup_vault   = "projects/policy-deployment-backups/locations/australia-southeast1/backupVaults/approved-vault"

  backup_rules {
    rule_id               = "rule-location"
    backup_retention_days = 30

    standard_schedule {
      recurrence_type = "DAILY"
      time_zone       = "Australia/Melbourne"  # non-compliant: must be "UTC"

      backup_window {
        start_hour_of_day = 0
        end_hour_of_day   = 23
      }
    }
  }
}
```

In the non-compliant example above, setting `time_zone` to anything other than `"UTC"` (e.g., `"Australia/Melbourne"`) will be flagged by the OPA policy.

## How to Use

1. In each `standard_schedule` block, set:

   * `time_zone = "UTC"`
2. Generate a Terraform plan:

   ```bash
   terraform plan -out=plan.json
   ```
3. Check compliance with OPA:

   ```bash
    opa eval  --data ./policies/gcp  --input inputs\gcp\backupdr\plan\backup_rules\standard_schedule\time_zone\plan.json  --format pretty  "data.terraform.gcp.security.backupdr.backup_plan.time_zone.message"
   ```
   <img width="758" alt="image" src="https://github.com/user-attachments/assets/7e4f40ac-af62-40b2-9654-234d07551dd3" />

    ```bash
   opa eval  --data ./policies/gcp  --input inputs\gcp\backupdr\plan\backup_rules\standard_schedule\time_zone\plan.json  --format pretty  "data.terraform.gcp.security.backupdr.backup_plan.time_zone.details"
    ```
   <img width="778" alt="image" src="https://github.com/user-attachments/assets/bfb42b79-e00b-4f07-9bd7-65a29d60758f" />


5. Address any violations before applying your Terraform changes.

---

> **🚀 Pro tip:** Using `UTC` ensures consistency across all schedules regardless of regional daylight-saving changes.
