# `access_restriction` for `google_backup_dr_backup_vault`

This README explains the **`access_restriction`** attribute of the **GCP Backup & DR Backup Vault** (`google_backup_dr_backup_vault`), covering:

- What `access_restriction` means  
- Our compliance criteria  
- Compliant vs. non-compliant Terraform examples  
- How to validate with OPA  

---

## What is `access_restriction`?

The **`access_restriction`** setting controls who can read or manage the contents of your Backup Vault:

- `UNRESTRICTED` – Any principal with the right permissions on the project can access the vault.  
- `WITHIN_ORGANIZATION` – Only principals in your GCP organization can access the vault.  

---

## Compliance Rules

1. **Must be set to `WITHIN_ORGANIZATION`**  
   - ✅ **Compliant**:
     ```hcl
     access_restriction = "WITHIN_ORGANIZATION"
     ```
   - ❌ **Non-compliant**:
     ```hcl
     access_restriction = "UNRESTRICTED"
     ```
   - ❌ **Non-compliant** (any other value):
     ```hcl
     access_restriction = "EXTERNAL_ONLY"
     ```

2. **Exact, case-sensitive match**  
   - Only `"WITHIN_ORGANIZATION"` is allowed for compliance.

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
provider "google-beta" {
  project = "policy-deployment-backups"
  region  = "australia-southeast1"
}

resource "google_backup_dr_backup_vault" "c" {
  provider                             = google-beta
  backup_vault_id                      = "backup-vault-c"
  location                             = "australia-southeast1"
  backup_minimum_enforced_retention_duration = "86400s"  # 1 day
  force_delete                         = true
  access_restriction                   = "WITHIN_ORGANIZATION"  # ✅ Compliant
  labels = {
    "goog-terraform-provisioned" = "true"
  }
}
```

### Non-Compliant Example (`nc.tf`)
```hcl
provider "google-beta" {
  project = "policy-deployment-backups"
  region  = "australia-southeast1"
}

resource "google_backup_dr_backup_vault" "nc" {
  provider                             = google-beta
  backup_vault_id                      = "backup-vault-nc"
  location                             = "australia-southeast1"
  backup_minimum_enforced_retention_duration = "86400s"
  force_delete                         = true
  access_restriction                   = "UNRESTRICTED"  # ❌ Non-compliant
  labels = {
    "goog-terraform-provisioned" = "true"
  }
}
```

---

## Validating with OPA

1. **Generate** your Terraform plan JSON:
   ```bash
   terraform plan -out=plan.tfplan
   terraform show -json plan.tfplan > plan-vault.json
   ```

2. **Evaluate** the `access_restriction` policy:
   ```bash
   opa eval  --data ./policies/gcp  --input ./inputs\gcp\backupdr\vault\access_restriction\plan.json  --format pretty  "data.terraform.gcp.security.backupdr.vault.access_restriction.message"
   ```
   <img width="758" alt="image" src="https://github.com/user-attachments/assets/b61fa919-a00f-4fea-9777-0f55262de9b5" />

   ```bash
   opa eval  --data ./policies/gcp  --input ./inputs\gcp\backupdr\vault\access_restriction\plan.json  --format pretty  "data.terraform.gcp.security.backupdr.vault.access_restriction.details"
   ```
   <img width="755" alt="image" src="https://github.com/user-attachments/assets/82718eb7-156e-4fc5-bfef-b6cb2f554b83" />

4. **Interpret** the results. Any vault with `access_restriction` not equal to `"WITHIN_ORGANIZATION"` will be flagged.
