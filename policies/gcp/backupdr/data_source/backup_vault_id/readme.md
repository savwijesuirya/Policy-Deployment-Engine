# 📦 Backup Vault ID Policy (Data Source)

This policy ensures that every `google_backup_dr_data_source` data source points to the approved Backup Vault.

## ✅ What It Checks

- **Attribute**: `backup_vault_id`  
- **Allowed value**:  
  ```
  google_backup_dr_backup_vault.approved_vault.id
  ```
- Any other vault reference (e.g. `unapproved-vault`) will be flagged as non-compliant.

## 📂 File Layout

```
policies/
└── gcp/
    └── backupdr/
        └── data_source/
            └── backup_vault_id/
                ├── policy.rego
                └── vars.rego
inputs/
└── gcp/
    └── backupdr/
        └── data_source/
            └── backup_vault_id/
                └── plan.json
```

## 🚀 How to Test

Run the following command from the repository root:

```bash
opa eval \
  --data ./policies/gcp \
  --input ./inputs/gcp/backupdr/data_source/backup_vault_id/plan.json \
  --format pretty \
  "data.terraform.gcp.security.backupdr.data_source.backup_vault_id.summary.message"
```

You should see output indicating the total number of data sources detected and how many are non-compliant.

## 📌 Example Output

```
[
  "Total GCP Backup DR Data Source detected: 2",
  "Non-compliant GCP Backup DR Data Source: 1/2",
  "GCP Backup DR Data Source 'nc' has backup_vault_id 'projects/…/unapproved-vault', expected 'projects/…/approved-vault'"
]
```

---

> *Tip:* Update `<YOUR_PROJECT_ID>` and `<YOUR_LOCATION>` in `vars.rego` to match your environment before running.
