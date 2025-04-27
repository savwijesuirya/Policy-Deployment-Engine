# `resource_type` for `google_backup_dr_backup_plan`

This README explains the **`resource_type`** attribute of the **GCP Backup & DR Backup Plan** (`google_backup_dr_backup_plan`), covering:

- What `resource_type` means  
- Our compliance criteria  
- Compliant vs. non-compliant Terraform examples  
- How to validate with OPA  

---

## What is `resource_type`?

The **`resource_type`** attribute tells Backup & DR which kind of GCP resource you are protecting. It must match one of your approved service identifiers (for example, `GCE_VM` for Compute Engine VMs).

---

## Compliance Rules

1. **Must be one of our approved types**  
   - ✅ **Compliant**:  
     ```hcl
     resource_type = "GCE_VM"
     ```  
   - ❌ **Non-compliant**:  
     ```hcl
     resource_type = "GCE_DISK"
     ```  
     (or any other unapproved string)

2. **Exact, case-sensitive match**  
   - Only uppercase letters, underscores; no extra spaces.

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
resource "google_backup_dr_backup_plan" "c" {
  backup_plan_id = "valid-resource"
  resource_type  = "GCE_VM"       # ✅ Approved type
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
  backup_plan_id = "invalid-resource"
  resource_type  = "GCE_DISK"     # ❌ Unapproved type
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
   terraform plan -out=plan.tfplan
   terraform show -json plan.tfplan > plan.json
   ```

2. **Evaluate** the `resource_type` policy:  
   ```bash
   opa eval --data ./policies/gcp --input ./inputs/gcp/backupdr/plan/resource_type/plan.json --format pretty "data.terraform.gcp.security.backupdr.backup_plan.resource_type.summary.message"
   ```

3. **Interpret** the results. Any backup plan with a `resource_type` not equal to `"GCE_VM"` will be flagged as non-compliant.
