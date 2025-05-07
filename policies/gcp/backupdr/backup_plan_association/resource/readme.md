# `resource` Attribute for `google_backup_dr_backup_plan_association`

This README explains the **`resource`** attribute of the **GCP Backup & DR Backup Plan Association** (`google_backup_dr_backup_plan_association`), covering:

- What the attribute represents  
- Our required resource path format  
- Compliant vs. non-compliant Terraform snippets  
- How to validate with OPA  

---

## What is `resource`?

The `resource` attribute is the **full Google Cloud resource path** of the Compute instance you’re associating with a backup plan. It must follow the GCP convention:

```
projects/{project_id}/zones/{zone}/instances/{instance_id}
```

---

## Compliance Rule

- ✅ **Compliant**:  
  - Must begin with `projects/{project}/zones/{location}-a/instances/`  
  - `{project}` and `{location}` must match the values in your resource’s `project` and `location` attributes.  

- ❌ **Non-compliant**:  
  - Anything not matching the pattern above, e.g.:  
    - A bare instance name (`"my-instance"`)  
    - Wrong zone suffix (`"-b"` or missing `-a`)  
    - Incorrect project ID  

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
resource "google_backup_dr_backup_plan_association" "c" {
  location                    = "australia-southeast1"
  resource_type               = "compute.googleapis.com/Instance"
  backup_plan_association_id = "valid-bpa-resource"
  resource                   = "projects/policy-deployment-backups/zones/australia-southeast1-a/instances/instance-1"
  backup_plan                = "valid-backup-plan"
}
```

### Non-Compliant Example (`nc.tf`)
```hcl
resource "google_backup_dr_backup_plan_association" "nc" {
   location                    = "australia-southeast1"
  resource_type               = "compute.googleapis.com/Instance"
  backup_plan_association_id = "invalid-bpa-resource"
  resource                   = "invalid-format-resource-name"  # Improper resource format
  backup_plan                = "invalid-backup-plan"
}
```

---

## Validating with OPA

1. **Generate** your Terraform plan JSON:
   ```bash
   terraform plan -out=plan.json
   ```
2. **Evaluate** the `resource` policy:
   ```bash
   opa eval  --data ./policies/gcp  --input ./inputs/gcp/backupdr/backup_plan_association/resource/plan.json  --format pretty  "data.terraform.gcp.security.backupdr.backup_plan_association.resource.message"
   ```
<img width="758" alt="image" src="https://github.com/user-attachments/assets/cbe91365-1488-459e-840c-1ddd01938c88" />
 
  ```bash
  opa eval  --data ./policies/gcp  --input ./inputs/gcp/backupdr/backup_plan_association/resource/plan.json  --format pretty  "data.terraform.gcp.security.backupdr.backup_plan_association.resource.details"
  ```
<img width="752" alt="image" src="https://github.com/user-attachments/assets/8f00a4cb-3ebf-4c56-a60c-40daca48903e" />


4. **Review** the output—any association whose `resource` path is malformed will be flagged as non-compliant.
