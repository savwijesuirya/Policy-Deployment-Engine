# `backup_rules` Block for `google_backup_dr_backup_plan`

This README explains the **`backup_rules`** block of the **GCP Backup & DR Backup Plan** (`google_backup_dr_backup_plan`), covering:

- What the `backup_rules` block does  
- Our compliance criteria  
- Compliant vs. non-compliant Terraform snippets  
- How to validate with OPA  

---

## What is `backup_rules`?

Each **`backup_rules`** block tells Backup & DR **when** and **how long** to keep your snapshots. Within it, you configure:

- **`rule_id`**  
  - A unique, human-readable name for the rule  
  - Must be lowercase, digits and hyphens only  
- **`backup_retention_days`**  
  - How many days to keep backups  
  - Must be an integer ≥ 1  
- **`standard_schedule`**  
  - **`recurrence_type`**: Only `"DAILY"` or `"HOURLY"`  
  - **`time_zone`**: A valid IANA timezone (e.g. `"UTC"`, `"Australia/Sydney"`)  
  - **`backup_window`**:  
    - **`start_hour_of_day`**, **`end_hour_of_day`**: integers 0–23, with `start < end`  

---

## Compliance Rules

1. **`rule_id`**  
   - ✅ **Compliant**: `daily-rule`, `rule-001`  
   - ❌ **Non-compliant**: `Daily Rule!`, `rule_1`

2. **`backup_retention_days`**  
   - ✅ **Compliant**: `7`, `30`  
   - ❌ **Non-compliant**: `0`, `-5`

3. **`recurrence_type`**  
   - ✅ **Compliant**: `"DAILY"`, `"HOURLY"`  
   - ❌ **Non-compliant**: `"WEEKLY"`, `"MONTHLY"`

4. **`backup_window` hours**  
   - ✅ **Compliant**: `start_hour_of_day = 0`, `end_hour_of_day = 23`  
   - ❌ **Non-compliant**: `start_hour_of_day = 23`, `end_hour_of_day = 0`  

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
resource "google_backup_dr_backup_plan" "c" {
  backup_plan_id = "plan-with-good-rules"
  resource_type  = "GCE_VM"
  location       = "australia-southeast1"
  project        = "policy-deployment-backups"
  backup_vault   = "projects/policy-deployment-backups/locations/australia-southeast1/backupVaults/approved-vault"

  backup_rules {
    rule_id               = "daily-rule"            # ✅ lowercase & hyphens
    backup_retention_days = 30                      # ✅ positive integer

    standard_schedule {
      recurrence_type = "DAILY"                     # ✅ allowed value
      time_zone       = "UTC"                       # ✅ valid IANA zone

      backup_window {
        start_hour_of_day = 0                       # ✅ 0–23, start < end
        end_hour_of_day   = 23
      }
    }
  }
}
```

### Non-Compliant Example (`nc.tf`)
```hcl
resource "google_backup_dr_backup_plan" "nc" {
  backup_plan_id = "plan-with-bad-rules"
  resource_type  = "GCE_VM"
  location       = "australia-southeast1"
  project        = "policy-deployment-backups"
  backup_vault   = "projects/policy-deployment-backups/locations/australia-southeast1/backupVaults/approved-vault"

  backup_rules {
    rule_id               = "Daily Rule!"           # ❌ uppercase & space & punctuation
    backup_retention_days = 0                       # ❌ must be ≥ 1

    standard_schedule {
      recurrence_type = "WEEKLY"                    # ❌ not allowed
      time_zone       = "UTC"

      backup_window {
        start_hour_of_day = 23                      # ❌ start ≥ end
        end_hour_of_day   = 0
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
2. **Evaluate** the `backup_rules` policy:
   ```bash
   opa eval    --data ./policies/gcp    --input ./inputs/gcp/backupdr/plan/backup_rules/plan.json    --format pretty    "data.terraform.gcp.security.backupdr.backup_plan.backup_rules.summary.message"
   ```
3. **Interpret** the output—any violation in your `backup_rules` block (invalid `rule_id`, zero retention, bad recurrence, or invalid window) will be flagged as non-compliant.
