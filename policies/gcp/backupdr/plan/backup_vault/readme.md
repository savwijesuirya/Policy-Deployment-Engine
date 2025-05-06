# `backup_vault` for `google_backup_dr_backup_plan`

This README explains the **`backup_vault`** attribute of the **GCP Backup & DR Backup Plan** (`google_backup_dr_backup_plan`), covering:

- What `backup_vault` does  
- Our compliance criteria  
- Compliant vs. non-compliant Terraform examples  
- How to validate with OPA  

---

## What is `backup_vault`?

The **`backup_vault`** attribute tells Backup & DR **where** to store your backups. It must reference a fully qualified Backup Vault resource in the same project and location.

Format:
```
projects/{{project}}/locations/{{location}}/backupVaults/{{vault_id}}
```

---

## Compliance Rules

1. **Fully-qualified path**  
   - ✅ **Compliant**:  
     ```
     projects/policy-deployment-backups/locations/australia-southeast1/backupVaults/approved-vault
     ```  
   - ❌ **Non-compliant**:  
     - `"approved-vault"` (missing `projects/.../locations/.../backupVaults/` prefix)  
     - `"projects/other-project/locations/australia-southeast1/backupVaults/approved-vault"` (wrong project)  
     - `"projects/policy-deployment-backups/locations/us-central1/backupVaults/approved-vault"` (wrong location)  

2. **Must point to an existing, approved vault**  
   - Only vaults you have created (e.g. via `google_backup_dr_backup_vault`) are valid.  

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
resource "google_backup_dr_backup_plan" "c" {
  backup_plan_id = "vault-test-plan"
  resource_type  = "GCE_VM"
  location       = "australia-southeast1"
  project        = "policy-deployment-backups"

  # ✅ Fully-qualified, approved vault
  backup_vault = "projects/policy-deployment-backups/locations/australia-southeast1/backupVaults/approved-vault"

  # At least one backup_rules block is still required
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
```

### Non-Compliant Example (`nc.tf`)
```hcl
resource "google_backup_dr_backup_plan" "nc" {
  backup_plan_id = "vault-test-plan"
  resource_type  = "GCE_VM"
  location       = "australia-southeast1"
  project        = "policy-deployment-backups"

  # ❌ Missing prefix
  backup_vault = "approved-vault"

  # ❌ Wrong project
  # backup_vault = "projects/other-project/locations/australia-southeast1/backupVaults/approved-vault"

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
```

---

## Validating with OPA

1. **Generate** your plan JSON:  
   ```bash
   terraform plan -out=plan.json
   ```
2. **Run** the `backup_vault` policy:  
   ```bash
    opa eval  --data ./policies/gcp  --input ./inputs/gcp/backupdr/plan/backup_vault/plan.json  --format pretty  "data.terraform.gcp.security.backupdr.backup_plan.backup_vault.message"
   ```
   <img width="755" alt="image" src="https://github.com/user-attachments/assets/434aac82-6d0b-45ef-b2ed-db7371a8647c" />
```bash
opa eval  --data ./policies/gcp  --input ./inputs/gcp/backupdr/plan/backup_vault/plan.json  --format pretty  "data.terraform.gcp.security.backupdr.backup_plan.backup_vault.details"
```
   <img width="769" alt="image" src="https://github.com/user-attachments/assets/294600cc-29f7-4874-a09d-e63c57b22e4e" />

4. **Review** the output—any mis-configured `backup_vault` reference will be flagged as non-compliant.
