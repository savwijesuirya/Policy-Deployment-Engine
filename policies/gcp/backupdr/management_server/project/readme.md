# `project` Attribute for `google_backup_dr_management_server`

This README explains the `project` attribute for the **GCP Backup & DR Management Server** (`google_backup_dr_management_server`) resource. It covers:

- What the attribute is for  
- How to configure it in Terraform  
- What constitutes **compliant** vs. **non-compliant** configurations  

---

## What is the `project` Attribute?

The `project` attribute specifies the GCP project ID in which the management server will be created. If you omit it, Terraform defaults to the provider’s project. Explicitly setting `project` helps avoid surprises when working across multiple GCP projects.

---

## Compliance Policy

Our policy enforces that every management server must live in the **approved** project:  
```
policy-deployment-backups
```
Any other project ID will be flagged as non-compliant.

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
resource "google_backup_dr_management_server" "c" {
  name     = "ms-console"
  location = "australia-southeast1"
  project  = "policy-deployment-backups"   # ✅ Approved project
  type     = "BACKUP_RESTORE"
}
```

### Non-Compliant Example (`nc.tf`)
```hcl
resource "google_backup_dr_management_server" "nc" {
  name     = "ms-console"
  location = "australia-southeast1"
  project  = "unknown-project"              # ❌ Not an approved project
  type     = "BACKUP_RESTORE"
}
```

In the non-compliant example, setting `project = "unknown-project"` will be caught by our OPA policy.

---

## How to Validate with OPA

1. Generate a Terraform plan JSON:
   ```bash
   terraform plan -out=plan.json
   ```
2. Run the OPA check:
   ```bash
   opa eval  --data ./policies/gcp  --input ./inputs/gcp/backupdr/management_server/project/plan.json  --format pretty  "data.terraform.gcp.security.backupdr.management_server.project.message"
   ```
   <img width="763" alt="image" src="https://github.com/user-attachments/assets/a8b1bd91-e273-4a99-9282-2c5226a17ea0" />
  ```bash
    opa eval  --data ./policies/gcp  --input ./inputs/gcp/backupdr/management_server/project/plan.json  --format pretty  "data.terraform.gcp.security.backupdr.management_server.project.details"
  ```
  <img width="760" alt="image" src="https://github.com/user-attachments/assets/dca5b3f7-3764-4dad-945e-b069bd2453d5" />

