# GCP Backup and DR: Location Policy

This policy ensures that all `google_backup_dr_backup_vault` resources are created in **approved GCP locations**, specifically within Australia.

## 📌 Policy Objective

The objective of this policy is to enforce the use of allowed GCP regions for backup vaults—primarily for **compliance, data residency**, and **latency optimization**. Only Australian regions are allowed.

## ✅ Compliant Example

```hcl
resource "google_backup_dr_backup_vault" "c" {
  provider = google-beta
  backup_vault_id = "backup-vault-c"
  location = "australia-southeast1"
  backup_minimum_enforced_retention_duration = "86400s"
}
```

```hcl
resource "google_backup_dr_backup_vault" "nc" {
  provider = google-beta
  backup_vault_id = "backup-vault-nc"
  location = "australia-southeast1"
  backup_minimum_enforced_retention_duration = "3600s"
}
```

## 🧪 How It Works

The policy checks the `location` attribute for all `google_backup_dr_backup_vault` resources. Allowed values:
- `australia-southeast1`
- `AU`

Any vault configured outside these regions will be marked as **non-compliant**.

## ▶️ Run the Policy

```bash
opa eval   --data ./policies/gcp   --input ./inputs/gcp/backupdr/vault/location/plan.json   --format pretty   "data.terraform.gcp.security.backupdr.vault.location.message"
```
<img width="768" alt="image" src="https://github.com/user-attachments/assets/2b90469e-1218-4bb6-9181-36828ec5d0b6" />

```bash
opa eval   --data ./policies/gcp   --input ./inputs/gcp/backupdr/vault/location/plan.json   --format pretty   "data.terraform.gcp.security.backupdr.vault.location.details"
```
<img width="760" alt="image" src="https://github.com/user-attachments/assets/88f0e8ff-31e6-4787-ac0a-9e92312fbe0e" />

