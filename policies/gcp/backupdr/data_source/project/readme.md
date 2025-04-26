# `project` Attribute for `google_backup_dr_data_source`

This README explains the `project` attribute for the **GCP Backup & DR Data Source** (`google_backup_dr_data_source`) resource. It covers:

- What the attribute is for  
- Our approved project ID  
- Compliant vs. non-compliant examples  
- How to validate with OPA  

---

## What is the `project` Attribute?

The `project` attribute specifies which Google Cloud project will own your Backup & DR data source. Ensuring a consistent, approved project ID helps centralize billing, logging, and policy enforcement.

---

## Approved Project

We only allow data sources to be created in the **`policy-deployment-backups`** project.

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
data "google_backup_dr_data_source" "c" {
  project         = "policy-deployment-backups"   # ✅ approved project
  location        = "australia-southeast1"
  backup_vault_id = "approved-vault"
  data_source_id  = "valid-data-source-id"
}
```

### Non-Compliant Example (`nc.tf`)
```hcl
data "google_backup_dr_data_source" "nc" {
  project         = "unknown-project"              # ❌ not on the approved list
  location        = "australia-southeast1"
  backup_vault_id = "approved-vault"
  data_source_id  = "valid-data-source-id"
}
```

---

## How to Validate with OPA

1. Create your Terraform plan:
   ```bash
   terraform plan -out=plan.json
   ```
2. Run the project-policy check:
   ```bash
   opa eval  --data ./policies/gcp  --input plan.json   --format pretty  "data.terraform.gcp.security.backupdr.data_source.project.summary.message"
   ```
3. Verify that all data sources use `policy-deployment-backups`.
