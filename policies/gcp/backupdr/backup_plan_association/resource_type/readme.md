# `resource_type` Attribute for `google_backup_dr_backup_plan_association`

This README explains the **`resource_type`** attribute of the **GCP Backup & DR Backup Plan Association** (`google_backup_dr_backup_plan_association`), covering:

- What the attribute represents  
- Our required values  
- Compliant vs. non-compliant Terraform snippets  
- How to validate with OPA  

---

## What is `resource_type`?

The `resource_type` field tells Google’s Backup & DR service which kind of resource you’re backing up. For the Backup Plan Association, **only Compute Engine instances** are supported:

```
compute.googleapis.com/Instance
```

---

## Compliance Rule

- ✅ **Compliant**:  
  - Exactly `"compute.googleapis.com/Instance"`

- ❌ **Non-compliant**:  
  - Any other string, for example:  
    - `"storage.googleapis.com/Bucket"`  
    - `"invalid.googleapis.com/Type"`  

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
resource "google_backup_dr_backup_plan_association" "c" {
  location                    = "australia-southeast1"
  resource_type               = "compute.googleapis.com/Instance"  # Valid resource type
  backup_plan_association_id = "valid-bpa-type"
  resource                   = "projects/policy-deployment-backups/zones/australia-southeast1-a/instances/instance-1"
  backup_plan                = "valid-backup-plan"    ✅ only supported type
}
```

### Non-Compliant Example (`nc.tf`)
```hcl
resource "google_backup_dr_backup_plan_association" "nc" {
 location                    = "australia-southeast1"
  resource_type               = "invalid.googleapis.com/Type"  # Invalid resource type
  backup_plan_association_id = "invalid-bpa-type"
  resource                   = "projects/policy-deployment-backups/zones/australia-southeast1-a/instances/instance-1"
  backup_plan                = "invalid-backup-plan"    # ❌ unsupported type
}
```

---

## Validating with OPA

1. **Generate** your Terraform plan JSON:
   ```bash
   terraform plan -out=plan.json
   ```
2. **Evaluate** the `resource_type` policy:
   ```bash
   opa eval  --data ./policies/gcp  --input ./inputs/gcp/backupdr/backup_plan_association/resource_type/plan.json  --format pretty "data.terraform.gcp.security.backupdr.backup_plan_association.resource_type.message"
   ```
   <img width="752" alt="image" src="https://github.com/user-attachments/assets/0891ea76-d689-4a7b-b646-ef909da4e97a" />
  ```bash
  opa eval --data ./policies/gcp --input ./inputs/gcp/backupdr/backup_plan_association/resource_type/plan.json --format pretty "data.terraform.gcp.security.backupdr.backup_plan_association.resource_type.details"
  ```
  <img width="757" alt="image" src="https://github.com/user-attachments/assets/a7deb547-f7b2-44a4-9902-f980d632c1da" />

3. **Review** the output—any Backup Plan Association whose `resource_type` isn’t exactly `compute.googleapis.com/Instance` will be flagged as non-compliant.
