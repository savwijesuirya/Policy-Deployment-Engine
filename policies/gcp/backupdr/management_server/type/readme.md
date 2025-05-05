# `type` Attribute for `google_backup_dr_management_server`

This README explains the `type` attribute for the **GCP Backup & DR Management Server** (`google_backup_dr_management_server`) resource. It covers:

- What the attribute is for  
- How to configure it in Terraform  
- What constitutes **compliant** vs. **non-compliant** configurations  

---

## What is the `type` Attribute?

The `type` attribute determines the role of the management server. Currently, only the value `BACKUP_RESTORE` is supported, which enables both backup and restore functionality. Omitting `type` defaults to `BACKUP_RESTORE`.

---

## Compliance Policy

Our policy enforces that every management server’s `type` must be set to:

```
BACKUP_RESTORE
```

Any other value (including an empty string) will be flagged as non-compliant.

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
resource "google_backup_dr_management_server" "c" {
  name     = "ms-console"
  location = "australia-southeast1"
  project  = "policy-deployment-backups"
  type     = "BACKUP_RESTORE"   # ✅ Must be exactly BACKUP_RESTORE
}
```

### Non-Compliant Example (`nc.tf`)
```hcl
resource "google_backup_dr_management_server" "nc" {
  name     = "ms-console"
  location = "australia-southeast1"
  project  = "policy-deployment-backups"
  type     = ""                 # ❌ Empty or invalid value
}
```

In the non-compliant example, setting `type = ""` will be caught by our OPA policy.

---

## How to Validate with OPA

1. Generate a Terraform plan JSON:
   ```bash
   terraform plan -out=plan.json
   ```
2. Run the OPA check:
   ```bash
   opa eval  --data ./policies/gcp  --input ./inputs/gcp/backupdr/management_server/type/plan.json  --format pretty  "data.terraform.gcp.security.backupdr.management_server.type.message"   
   ```
   <img width="749" alt="image" src="https://github.com/user-attachments/assets/a3550d98-fe70-4685-b3be-4f60b6db1fc4" />
```bash
   opa eval  --data ./policies/gcp  --input ./inputs/gcp/backupdr/management_server/type/plan.json  --format pretty  "data.terraform.gcp.security.backupdr.management_server.type.details"
```
   <img width="767" alt="image" src="https://github.com/user-attachments/assets/fdf9386d-3673-4931-8a33-35443138066e" />

