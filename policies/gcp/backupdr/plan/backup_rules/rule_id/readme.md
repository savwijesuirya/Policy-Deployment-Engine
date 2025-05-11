# `rule_id` Attribute in `backup_rules` for `google_backup_dr_backup_plan`

This README describes the compliance requirement for the `rule_id` attribute inside the `backup_rules` block of the `google_backup_dr_backup_plan` resource.

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
    rule_id               = "invalid_rule_id"  # invalid: must start with "rule-" and use lowercase hyphens only
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

In the non-compliant example, the `rule_id` value does not follow the required pattern (it must start with `rule-` and use only lowercase letters and hyphens).

## How to Use

1. Ensure each `backup_rules` block sets `rule_id` to a lowercase, hyphen-separated string starting with `rule-`.
2. Generate a Terraform plan:

   ```bash
   terraform plan -out=plan.json
   ```
3. Check compliance with OPA:

   ```bash
   opa eval  --data ./policies/gcp  --input inputs\gcp\backupdr\plan\backup_rules\rule_id\plan.json  --format pretty  "data.terraform.gcp.security.backupdr.backup_plan.rule_id.message"
   ```
   <img width="746" alt="image" src="https://github.com/user-attachments/assets/1159f2ae-0bd1-4a08-98ca-d85a62e9105f" />

    ```bash
    opa eval  --data ./policies/gcp  --input inputs\gcp\backupdr\plan\backup_rules\rule_id\plan.json  --format pretty  "data.terraform.gcp.security.backupdr.backup_plan.rule_id.details"
    ```
   <img width="759" alt="image" src="https://github.com/user-attachments/assets/fc77100c-210c-42c6-8389-4a0de28dd701" />


5. Fix any reported violations before applying changes.

---

> **🚀 Pro tip:** Keep your `rule_id`s consistent—using a clear prefix and hyphens improves readability and auditability.
