# `location` for `google_backup_dr_backup_plan`

This README explains the **`location`** attribute of the **GCP Backup & DR Backup Plan** (`google_backup_dr_backup_plan`), covering:

- What `location` does  
- Our compliance criteria  
- Compliant vs. non-compliant Terraform examples  
- How to validate with OPA  

---

## What is `location`?

The **`location`** attribute specifies the GCP region in which your backup plan will run and store its metadata. It must match one of your approved regions for data residency and performance.

---

## Compliance Rules

1. **Must be an approved region**  
   - ✅ **Compliant**:  
     ```
     australia-southeast1
     ```  
   - ❌ **Non-compliant**:  
     - `us-central1` (not on our approved list)  
     - `europe-west1`  

2. **Exact match, case-sensitive**  
   - Must exactly match the region string (lowercase, hyphens, no extra whitespace).

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
resource "google_backup_dr_backup_plan" "c" {
  backup_plan_id = "location-test-plan"
  resource_type  = "GCE_VM"

  # ✅ Approved region
  location       = "australia-southeast1"

  project        = "policy-deployment-backups"
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

### Non-Compliant Example (`nc.tf`)
```hcl
resource "google_backup_dr_backup_plan" "nc" {
  backup_plan_id = "location-test-plan"
  resource_type  = "GCE_VM"

  # ❌ Unapproved region
  location       = "us-central1"

  project        = "policy-deployment-backups"
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

## Validating with OPA

1. **Generate** your plan JSON:  
   ```bash
   terraform plan -out=plan.json
   ```
2. **Run** the `location` policy:  
   ```bash
   opa eval  --data ./policies/gcp  --input ./inputs/gcp/backupdr/backup_plan_association/resource/plan.json  --format pretty  "data.terraform.gcp.security.backupdr.backup_plan_association.resource.message"
   ```
   <img width="754" alt="image" src="https://github.com/user-attachments/assets/aee9b90c-e2d3-49aa-bf11-ee1fc63c4b90" />

```bash
   opa eval --data ./policies/gcp --input ./inputs/gcp/backupdr/plan/location/plan.json --format pretty "data.terraform.gcp.security.backupdr.backup_plan.location.details"
```
   <img width="767" alt="image" src="https://github.com/user-attachments/assets/5b14b715-6dc0-40d1-951e-e9a6820d9e04" />

3. **Review** the output—any backup plan with an unapproved region will be flagged as non-compliant.
