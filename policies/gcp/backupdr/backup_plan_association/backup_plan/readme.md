# `backup_plan` Attribute for `google_backup_dr_backup_plan_association`

This README describes the **`backup_plan`** attribute for the **GCP Backup & DR Backup Plan Association** (`google_backup_dr_backup_plan_association`) resource. It covers:

- What the attribute does  
- Our compliance rule  
- Compliant vs. non-compliant Terraform snippets  
- How to run the OPA policy check  

---

## What is the `backup_plan` Attribute?

The `backup_plan` attribute names the Backup Plan to which a resource (e.g. a VM instance) is associated. It must be a non-empty string so that every association references a real plan.

---

## Compliance Rule

- ✅ **Compliant**: Any non-empty string (e.g. `"daily-backup"`, `"prod-plan"`)  
- ❌ **Non-compliant**: An empty string (`""`)

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
resource "google_backup_dr_backup_plan_association" "c" {
  location                    = "australia-southeast1"
  resource_type               = "compute.googleapis.com/Instance"
  backup_plan_association_id = "valid-backup-plan-assoc"
  resource                   = "projects/policy-deployment-backups/zones/australia-southeast1-a/instances/instance-1"
  backup_plan                = "valid-backup-plan"  # Valid backup plan name
}
```

### Non-Compliant Example (`nc.tf`)
```hcl
resource "google_backup_dr_backup_plan_association" "nc" {
  location                    = "australia-southeast1"
  resource_type               = "compute.googleapis.com/Instance"
  backup_plan_association_id = "invalid-backup-plan-assoc"
  resource                   = "projects/policy-deployment-backups/zones/australia-southeast1-a/instances/instance-1"
  backup_plan                = ""  # Missing or invalid backup plan
}
```

---

## Validating with OPA

1. Generate a Terraform plan JSON:
   ```bash
   terraform plan -out=plan.json
   ```
2. Run the `backup_plan` policy:
   ```bash
   opa eval --data ./policies/gcp --input ./inputs/gcp/backupdr/backup_plan_association/backup_plan/plan.json --format pretty "data.terraform.gcp.security.backupdr.backup_plan_association.backup_plan.summary"    
   ```
3. Confirm that no associations have an empty `backup_plan`.
