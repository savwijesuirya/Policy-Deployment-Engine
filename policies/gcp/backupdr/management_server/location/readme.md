# `location` Attribute for `google_backup_dr_management_server`

This README explains the `location` attribute for the **GCP Backup & DR Management Server** (`google_backup_dr_management_server`) resource. It covers:

- What the attribute is for  
- How to configure it in Terraform  
- What constitutes **compliant** vs. **non-compliant** configurations  

---

## What is the `location` Attribute?

The `location` attribute specifies the GCP region where your management server (management console) will be created. This determines:

- Which data center region hosts the service  
- Latency and data-sovereignty characteristics  

**This field is required.**

---

## Compliance Policy

Our policy enforces that all management servers must live in one of our **approved regions**.  For example:

- `australia-southeast1`  

Any other region string will be flagged as non-compliant.

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
resource "google_backup_dr_management_server" "c" {
  name     = "ms-console"
  project  = "policy-deployment-backups"
  type     = "BACKUP_RESTORE"

  # ✅ Approved region
  location = "australia-southeast1"
}
```

### Non-Compliant Example (`nc.tf`)
```hcl
resource "google_backup_dr_management_server" "nc" {
  name     = "ms-console"
  project  = "policy-deployment-backups"
  type     = "BACKUP_RESTORE"

  # ❌ Not on the approved list
  location = "europe-west1"
}
```

In the second example, `"europe-west1"` will be caught by our OPA policy as non-compliant because it is not one of the approved locations.

---

## How to Use

1. Set `location` in your Terraform resource to an approved region (e.g., `australia-southeast1`).  
2. Run `terraform plan -out=plan` to produce a JSON plan.  
3. Check compliance with OPA:
   ```bash
   opa eval   --data ./policies/gcp  --input ./inputs/gcp/backupdr/management_server/location/plan.json  --format pretty  "data.terraform.gcp.security.backupdr.management_server.location.message"
   ```
   <img width="764" alt="image" src="https://github.com/user-attachments/assets/1c191bda-558a-4263-8f96-f908d3959a61" />
  ```bash
    opa eval   --data ./policies/gcp  --input ./inputs/gcp/backupdr/management_server/location/plan.json  --format pretty  "data.terraform.gcp.security.backupdr.management_server.location.details"
  ```
  <img width="761" alt="image" src="https://github.com/user-attachments/assets/c3eb8c72-fee5-4542-bee8-9da4177d2347" />

4. Address any violations before applying.

---

> **🔑 Tip:** Keep your region list centralized in your policy vars so you can easily update it as requirements change!
