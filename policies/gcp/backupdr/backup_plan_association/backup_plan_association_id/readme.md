# `backup_plan_association_id` Attribute for `google_backup_dr_backup_plan_association`

This README explains the **`backup_plan_association_id`** attribute of the **GCP Backup & DR Backup Plan Association** (`google_backup_dr_backup_plan_association`) resource. It covers:

- Purpose of the attribute  
- Our naming rule  
- Compliant vs. non-compliant Terraform snippets  
- How to test with OPA  

---

## What is `backup_plan_association_id`?

The `backup_plan_association_id` is a user-defined identifier for each Backup Plan Association. It appears in logs and APIs, so it must follow a strict naming pattern:

> **Lowercase letters**, **digits**, and **dashes** only — no spaces, underscores, or special characters.

---

## Compliance Rule

- ✅ **Compliant**: IDs matching `^[a-z0-9-]+$`  
  - Examples: `valid-bpa`, `prod-backup-assoc`, `vm01-backup`  
- ❌ **Non-compliant**: Anything else  
  - Examples: `BPA_01`, `backup assoc`, `!bpa02`

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
resource "google_backup_dr_backup_plan_association" "c" {
  location                    = "australia-southeast1"
  resource_type               = "compute.googleapis.com/Instance"
  backup_plan_association_id = "valid-bpa"
  resource                   = "projects/policy-deployment-backups/zones/australia-southeast1-a/instances/my-instance"
  backup_plan                = "backup-plan-compliant"
  project                    = "policy-deployment-backups"
}
```

### Non-Compliant Example (`nc.tf`)
```hcl
resource "google_backup_dr_backup_plan_association" "nc" {
  location                    = "australia-southeast1"                      # Non-approved location
  resource_type               = "compute.googleapis.com/Instance"
  backup_plan_association_id = "invalid id!"                      # Invalid: contains space and special character
  resource                   = "projects/policy-deployment-backups/zones/us-central1-a/instances/invalid-instance"
  backup_plan                = "backup-plan-noncompliant"
  project                    = "policy-deployment-backups"
}
```

---

## Validating with OPA

1. **Create** a Terraform plan JSON:
   ```bash
   terraform plan -out=plan.json
   ```
2. **Run** the `backup_plan_association_id` policy:
   ```bash
   opa eval --data ./policies/gcp --input ./inputs/gcp/backupdr/backup_plan_association_id/backup_plan_association_id/plan.json --format pretty "data.terraform.gcp.security.backupdr.backup_plan_association.backup_plan_association_id.summary.message"
   ```
3. **Verify** that any offending IDs are flagged as non-compliant.
