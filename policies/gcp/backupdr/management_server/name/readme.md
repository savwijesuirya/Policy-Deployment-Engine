# `name` Attribute for `google_backup_dr_management_server`

This README explains the `name` attribute for the **GCP Backup & DR Management Server** (`google_backup_dr_management_server`) resource. It covers:

- What the attribute is for  
- How to configure it in Terraform  
- What constitutes **compliant** vs. **non-compliant** configurations  

---

## What is the `name` Attribute?

The `name` attribute specifies the identifier for your management server (management console). It must be:

- Unique within the GCP project  
- Comprised of lowercase letters, digits, and dashes (`-`)  
- No spaces, underscores, or special characters  

This field is **required**.

---

## Compliance Policy

Our policy enforces that all management server names follow the pattern:  
```
^[a-z0-9-]+$
```
Any deviation (uppercase letters, spaces, punctuation) will be flagged as non-compliant.

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
resource "google_backup_dr_management_server" "c" {
  # ✅ Lowercase letters, digits and dashes only
  name     = "ms-console"
  project  = "policy-deployment-backups"
  location = "australia-southeast1"
  type     = "BACKUP_RESTORE"
}
```

### Non-Compliant Example (`nc.tf`)
```hcl
resource "google_backup_dr_management_server" "nc" {
  # ❌ Contains uppercase letters and punctuation
  name     = "MS_Console!"
  project  = "policy-deployment-backups"
  location = "australia-southeast1"
  type     = "BACKUP_RESTORE"
}
```

In the non-compliant example, `"MS_Console!"` will be caught by our OPA policy because it includes uppercase letters, an underscore, and an exclamation mark—none of which are allowed.

---

## How to Use

1. Set `name` in your Terraform resource to a lowercase-and-dash only string (e.g., `ms-console`).  
2. Run `terraform plan -out=plan.json` to produce a JSON plan.  
3. Validate compliance with OPA:
   ```bash
   opa eval   --data ./policies/gcp  --input ./inputs/gcp/backupdr/management_server/name/plan.json --format pretty  "data.terraform.gcp.security.backupdr.management_server.name.message"    
   ```
   <img width="758" alt="image" src="https://github.com/user-attachments/assets/76cd85c3-d082-42a0-b724-3e18aaf6c4f4" />
  ```bash
    opa eval   --data ./policies/gcp  --input ./inputs/gcp/backupdr/management_server/name/plan.json --format pretty  "data.terraform.gcp.security.backupdr.management_server.name.details"
  ```
  <img width="761" alt="image" src="https://github.com/user-attachments/assets/2f5e7183-4115-4f27-b766-9169ef0ede1f" />
