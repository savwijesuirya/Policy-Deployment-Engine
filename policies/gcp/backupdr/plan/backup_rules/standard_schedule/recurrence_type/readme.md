# `recurrence_type` Attribute in `standard_schedule` for `google_backup_dr_backup_plan`

This README describes the compliance requirement for the `recurrence_type` attribute inside each `standard_schedule` block of the `backup_rules` in the `google_backup_dr_backup_plan` resource.

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
      recurrence_type = "DAILY"  # only DAILY allowed
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
      recurrence_type   = "HOURLY"  # non-compliant: only DAILY is supported
      hourly_frequency  = 1         # presence of hourly_frequency indicates invalid recurrence_type
      time_zone         = "UTC"

      backup_window {
        start_hour_of_day = 0
        end_hour_of_day   = 23
      }
    }
  }
}
```

In the non-compliant example, setting `recurrence_type` to `HOURLY` (and defining `hourly_frequency`) is not allowed. To comply, always use `recurrence_type = "DAILY"` and omit `hourly_frequency`.

## How to Use

1. In each `standard_schedule` block, set:

   * `recurrence_type = "DAILY"`
   * Do **not** include `hourly_frequency`.
2. Generate a Terraform plan:

   ```bash
   terraform plan -out=plan.json
   ```
3. Evaluate compliance with OPA:

   ```bash
   opa eval  --data ./policies/gcp  --input inputs\gcp\backupdr\plan\backup_rules\standard_schedule\recurrence_type\plan.json  --format pretty  "data.terraform.gcp.security.backupdr.backup_plan.recurrence_type.message"
   ```
   <img width="760" alt="image" src="https://github.com/user-attachments/assets/7366243c-a495-43ca-a814-35173ea96ad7" />

   ```bash
   opa eval  --data ./policies/gcp  --input inputs\gcp\backupdr\plan\backup_rules\standard_schedule\recurrence_type\plan.json  --format pretty  "data.terraform.gcp.security.backupdr.backup_plan.recurrence_type.details"
   ```
   <img width="756" alt="image" src="https://github.com/user-attachments/assets/8c688f91-4ba5-415a-a763-9f63812b6b37" />

   
4. Address any violations before applying your Terraform changes.

---

> **🚀 Pro tip:** Consistent daily backups simplify retention tracking—avoid hourly schedules in standard\_schedule to stay compliant.
