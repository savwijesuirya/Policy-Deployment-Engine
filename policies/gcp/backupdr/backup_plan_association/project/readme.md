# `project` Attribute for `google_backup_dr_backup_plan_association`

This README covers the **`project`** attribute of the **GCP Backup & DR Backup Plan Association** (`google_backup_dr_backup_plan_association`) resource, including:

- What the attribute controls  
- Our approved project ID  
- Compliant vs. non-compliant Terraform snippets  
- How to validate with OPA  

---

## What is `project`?

The `project` attribute specifies **which GCP Project** owns the Backup Plan Association. To keep all Backup & DR configurations centralized and auditable, we require associations to live in our designated project.

---

## Compliance Rule

- ✅ **Compliant**: `project = "policy-deployment-backups"`  
- ❌ **Non-compliant**: Any other project string, e.g. `"my-other-project"`, `"12345"`, etc.

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
resource "google_backup_dr_backup_plan_association" "c" {
  backup_plan                = "daily-backup"
  backup_plan_association_id = "valid-bpa-project"
  location                   = "australia-southeast1"
  project                    = "policy-deployment-backups"  # ✅ approved project
  resource                   = "projects/policy-deployment-backups/zones/australia-southeast1-a/instances/my-instance"
  resource_type              = "compute.googleapis.com/Instance"
}
```

### Non-Compliant Example (`nc.tf`)
```hcl
resource "google_backup_dr_backup_plan_association" "nc" {
  backup_plan                = "daily-backup"
  backup_plan_association_id = "valid-bpa-project"
  location                   = "australia-southeast1"
  project                    = "my-other-project"            # ❌ unapproved project
  resource                   = "projects/policy-deployment-backups/zones/australia-southeast1-a/instances/my-instance"
  resource_type              = "compute.googleapis.com/Instance"
}
```

---

## Validating with OPA

1. **Create** your Terraform plan JSON:
   ```bash
   terraform plan -out=plan.json
   ```
2. **Evaluate** the `project` policy:
   ```bash
     opa eval  --data ./policies/gcp   --input ./inputs/gcp/backupdr/backup_plan_association/project/plan.json  --format pretty  "data.terraform.gcp.security.backupdr.backup_plan_association.project.summary.message" ```
3. **Inspect** the output—any association whose `project` is not `"policy-deployment-backups"` will be reported as non-compliant.
