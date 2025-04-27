# `backup_plan_id` Attribute for `google_backup_dr_backup_plan`

This README explains the **`backup_plan_id`** attribute of the **GCP Backup & DR Backup Plan** (`google_backup_dr_backup_plan`), covering:

- What the attribute represents  
- Our naming rules  
- Compliant vs. non-compliant Terraform snippets  
- How to validate with OPA  

---

## What is `backup_plan_id`?

The `backup_plan_id` is the unique identifier you assign to your backup plan. It appears in URLs and logs, so it must be:

- **Lowercase**  
- **Alphanumeric** with **hyphens** only  
- **No spaces**, **no underscores**, **no punctuation**  

A good ID might look like `daily-backup-001`.

---

## Compliance Rule

- ✅ **Compliant**:  
  - Matches the regex `^[a-z0-9-]+$`  
  - Examples:  
    - `compliant-plan-id`  
    - `bpa-2025-04`  

- ❌ **Non-compliant**:  
  - Contains invalid characters (spaces, underscores, uppercase, punctuation)  
  - Examples:  
    - `Invalid Plan ID!`  
    - `plan_01`  
    - `Plan-02`  

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
resource "google_backup_dr_backup_plan" "c" {
  backup_plan_id = "compliant-plan-id"     # ✅ matches lowercase & hyphens
  resource_type  = "GCE_VM"
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
```

### Non-Compliant Example (`nc.tf`)
```hcl
resource "google_backup_dr_backup_plan" "nc" {
  backup_plan_id = "Invalid Plan ID!"      # ❌ contains spaces and punctuation
  resource_type  = "GCE_VM"
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
```

---

## Validating with OPA

1. **Generate** your Terraform plan JSON:
   ```bash
   terraform plan -out=plan.json
   ```
2. **Evaluate** the `backup_plan_id` policy:
   ```bash
    opa eval   --data ./policies/gcp   --input ./inputs/gcp/backupdr/plan/backup_plan_id/plan.json   --format pretty   "data.terraform.gcp.security.backupdr.backup_plan.backup_plan_id.summary.message"
   ```
3. **Review** the output—any Backup Plan whose `backup_plan_id` doesn’t match `^[a-z0-9-]+$` will show up as non-compliant.
