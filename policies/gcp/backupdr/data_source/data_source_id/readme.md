# `data_source_id` Attribute for `google_backup_dr_data_source`

This README explains the `data_source_id` attribute for the **GCP Backup & DR Data Source** (`google_backup_dr_data_source`) resource. It covers:

- What the attribute is for  
- Our naming policy  
- Compliant vs. non-compliant examples  
- How to validate with OPA  

---

## What is the `data_source_id` Attribute?

The `data_source_id` is a user-defined identifier for your backup data source. It must be unique within the backup vault and follow a strict naming convention to avoid errors and ensure consistency.

---

## Naming Policy

✔️ **Allowed characters**:  
- Lowercase letters (`a–z`)  
- Digits (`0–9`)  
- Hyphens (`-`)  

❌ **Disallowed**:  
- Uppercase letters  
- Spaces  
- Special characters (e.g. `!`, `_`, `@`, etc.)

Our OPA policy enforces this with the regular expression:

```
^[a-z0-9-]+$
```

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
data "google_backup_dr_data_source" "c" {
  project         = "policy-deployment-backups"
  location        = "australia-southeast1"
  backup_vault_id = "approved-vault"
  data_source_id  = "valid-data-source-id"   # ✅ lowercase, digits, hyphens only
}
```

### Non-Compliant Example (`nc.tf`)
```hcl
data "google_backup_dr_data_source" "nc" {
  project         = "policy-deployment-backups"
  location        = "australia-southeast1"
  backup_vault_id = "approved-vault"
  data_source_id  = "Invalid_ID!"            # ❌ uppercase, underscore, exclamation
}
```

---

## How to Validate with OPA

1. Create your Terraform plan:
   ```bash
   terraform plan -out=plan.json
   ```
2. Run the policy check:
   ```bash
   opa eval --data ./policies/gcp --input plan.json --format pretty  "data.terraform.gcp.security.backupdr.data_source.data_source_id.summary.message"
   ```
