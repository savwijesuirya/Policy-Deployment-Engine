# `location` Attribute for `google_backup_dr_backup_plan_association`

This README explains the **`location`** attribute of the **GCP Backup & DR Backup Plan Association** (`google_backup_dr_backup_plan_association`) resource. It covers:

- What the attribute controls  
- Our allowed regions  
- Compliant vs. non-compliant Terraform snippets  
- How to validate with OPA  

---

## What is `location`?

The `location` attribute determines **where** your Backup Plan Association is created. GCP enforces geographic boundaries for data residency, so picking an approved region is critical for compliance and performance.

---

## Compliance Rule

- ✅ **Compliant**: `location = "australia-southeast1"`  
- ❌ **Non-compliant**: Any other region value, e.g. `"us-west1"`, `"europe-west1"`, etc.

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
resource "google_backup_dr_backup_plan_association" "c" {
 location                    = "australia-southeast1"
  resource_type               = "compute.googleapis.com/Instance"
  backup_plan_association_id = "valid-bpa"
  resource                   = "projects/policy-deployment-backups/zones/australia-southeast1-a/instances/my-instance"
  backup_plan                = "backup-plan-compliant"
  project                    = "policy-deployment-backups"
}
```

### Non-Compliant Example (`nc.tf`)
```hcl
resource "google_backup_dr_backup_plan_association" "nc" {
   location                    = "us-west1"                      # Non-approved location
  resource_type               = "compute.googleapis.com/Instance"
  backup_plan_association_id = "valid-bpa"
  resource                   = "projects/policy-deployment-backups/zones/us-central1-a/instances/invalid-instance"
  backup_plan                = "backup-plan-noncompliant"
  project                    = "policy-deployment-backups"
}

```

---

## Validating with OPA

1. **Generate** your Terraform plan JSON:
   ```bash
   terraform plan -out=plan.json
   ```
2. **Run** the location policy:
   ```bash
    opa eval  --data ./policies/gcp  --input ./inputs/gcp/backupdr/backup_plan_association/location/plan.json --format pretty  "data.terraform.gcp.security.backupdr.backup_plan_association.location.message" 
   ```
   <img width="781" alt="image" src="https://github.com/user-attachments/assets/7aa6a292-ff23-4f92-a964-a13f4b75f8bb" />

 ```bash
opa eval  --data ./policies/gcp  --input ./inputs/gcp/backupdr/backup_plan_association/location/plan.json --format pretty  "data.terraform.gcp.security.backupdr.backup_plan_association.location.details" 
```
 <img width="782" alt="image" src="https://github.com/user-attachments/assets/c4d9036a-4406-496e-950f-4bff0eb2456d" />

3. **Review** output—any `location` not set to `"australia-southeast1"` will be flagged as non-compliant.

---

By following this guide, you ensure all Backup Plan Associations are created only in the approved `australia-southeast1` region.
