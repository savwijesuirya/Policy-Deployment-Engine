# `location` Attribute for `google_backup_dr_data_source`

This README explains the `location` attribute for the **GCP Backup & DR Data Source** (`google_backup_dr_data_source`) resource. It covers:

- What the attribute is for  
- Our approved locations  
- Compliant vs. non-compliant examples  
- How to validate with OPA  

---

## What is the `location` Attribute?

The `location` specifies the GCP region where your backup data source resides. Choosing a supported region ensures low-latency access and meets data-sovereignty requirements.

---

## Approved Regions

We only allow Backup & DR data sources in the following region(s):

- `australia-southeast1`

Any other region will be flagged by our policy.

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
data "google_backup_dr_data_source" "c" {
  project         = "policy-deployment-backups"
  location        = "australia-southeast1"   # ✅ allowed region
  backup_vault_id = "approved-vault"
  data_source_id  = "valid-data-source-id"
}
```

### Non-Compliant Example (`nc.tf`)
```hcl
data "google_backup_dr_data_source" "nc" {
  project         = "policy-deployment-backups"
  location        = "us-central1"             # ❌ not on the approved list
  backup_vault_id = "approved-vault"
  data_source_id  = "valid-data-source-id"
}
```

---

## How to Validate with OPA

1. Generate your Terraform plan:
   ```bash
   terraform plan -out=plan.json
   ```
2. Run the location policy check:
   ```bash
   opa eval  --data ./policies/gcp  --input plan.json  --format pretty  "data.terraform.gcp.security.backupdr.data_source.location.summary.message"
   ```
3. Confirm that only `australia-southeast1` is used in your DR data sources.
