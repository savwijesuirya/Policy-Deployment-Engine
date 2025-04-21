# 🛡️ GCP Backup DR – `standard_schedule` Policy

This policy validates the `standard_schedule` block in `google_backup_dr_backup_plan` resources to ensure backups are configured with a valid and consistent schedule.

---

## ✅ What It Checks

This policy enforces:

- `recurrence_type` is **exactly** `"DAILY"`
- `time_zone` is **exactly** `"UTC"`
- `backup_window` has:
  - `start_hour_of_day` between `0` and `23`
  - `end_hour_of_day` between `1` and `24`
  - `end_hour_of_day` must be **greater than** `start_hour_of_day`

Any deviation from these values is flagged as **non-compliant**.

---

## 🧭 Directory Structure

Here’s how everything is organized in your repo:

POLICY-DEPLOYMENT-ENGINE/ ├── inputs/ │ └── gcp/ │ └── backupdr/ │ └── plan/ │ └── standard_schedule/ │ └── plan.json ├── policies/ │ └── gcp/ │ └── backupdr/ │ └── plan/ │ └── standard_schedule/ │ └── policy.rego

yaml
Copy
Edit

---

## 🚀 Run the Policy with OPA

Use the command below to evaluate your Terraform plan against this policy:

```bash
opa eval \
  --data ./policies/gcp \
  --input ./inputs/gcp/backupdr/plan/standard_schedule/plan.json \
  --format pretty \
  "data.terraform.gcp.security.backupdr.backup_plan.standard_schedule.summary.message"
🧾 Sample Output
arduino
Copy
Edit
[
  "Total GCP Backup DR Backup Plan detected: 2",
  "Non-compliant GCP Backup DR Backup Plan: 1/2",
  "GCP Backup DR Backup Plan 'nc' has invalid standard_schedule config: recurrence_type='DAILY', time_zone='Mars/Zone', backup_window='[{start_hour_of_day:22, end_hour_of_day:21}]'"
]
