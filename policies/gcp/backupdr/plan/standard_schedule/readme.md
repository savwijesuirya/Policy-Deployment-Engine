# 🛡️ GCP Backup DR – `standard_schedule` Policy

This policy validates the `standard_schedule` block in `google_backup_dr_backup_plan` resources to ensure backups are configured with a valid and consistent schedule.

---

## ✅ What It Checks

This policy enforces the following conditions within the `standard_schedule` block:

- `recurrence_type` must be **exactly** `"DAILY"`.
- `time_zone` must be **exactly** `"UTC"`.
- The `backup_window` must satisfy these criteria:
    - `start_hour_of_day` is an integer between `0` and `23` (inclusive).
    - `end_hour_of_day` is an integer between `1` and `24` (inclusive).
    - `end_hour_of_day` must be **greater than** `start_hour_of_day`.

Any deviation from these values will be flagged as **non-compliant**.

---

## 🧭 Directory Structure

Here’s how the files are organized in your repository:

```
POLICY-DEPLOYMENT-ENGINE/
├── inputs/
│   └── gcp/
│       └── backupdr/
│           └── plan/
│               └── standard_schedule/
│                   └── plan.json
├── policies/
│   └── gcp/
│       └── backupdr/
│           └── plan/
│               └── standard_schedule/
│                   └── policy.rego
```

---

## 🚀 Run the Policy with OPA

Use the command below to evaluate your Terraform plan against this policy:

```bash
opa eval --data ./policies/gcp --input ./inputs/gcp/backupdr/plan/standard_schedule/plan.json --format pretty "data.terraform.gcp.security.backupdr.backup_plan.standard_schedule.summary.message"
```

```
🧾 Sample Output
[
  "Total GCP Backup DR Backup Plan detected: 2",
  "Non-compliant GCP Backup DR Backup Plan: 1/2",
  "GCP Backup DR Backup Plan 'nc' has invalid standard_schedule config: recurrence_type='DAILY', time_zone='Mars/Zone', backup_window='[{start_hour_of_day:22, end_hour_of_day:21}]'"
]
```
