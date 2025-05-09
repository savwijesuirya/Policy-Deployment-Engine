# `peering_mode` Attribute in `networks` for `google_backup_dr_management_server`

This README describes the compliance requirement for the `peering_mode` attribute inside the `networks` block of the `google_backup_dr_management_server` resource.

---

## Compliant Example (`c.tf`)

```hcl
# Resource is compliant when peering_mode is set to PRIVATE_SERVICE_ACCESS
resource "google_backup_dr_management_server" "c" {
  provider = google
  location = "australia-southeast1"
  name     = "ms-console"
  type     = "BACKUP_RESTORE"

  networks {
    network      = "projects/policy-deployment-backups/global/networks/vpc-network"
    peering_mode = "PRIVATE_SERVICE_ACCESS"
  }
}
```

---

## Non‑Compliant Example (`nc.tf`)

```hcl
# Resource is non‑compliant when peering_mode is empty or invalid
resource "google_backup_dr_management_server" "nc" {
  provider = google
  location = "australia-southeast1"
  name     = "ms-console"
  type     = "BACKUP_RESTORE"

  networks {
    network      = "projects/policy-deployment-backups/global/networks/vpc-network"
    peering_mode = ""  # invalid value: must be PRIVATE_SERVICE_ACCESS
  }
}
```

In the non‑compliant example above, the empty `peering_mode` will be flagged by the OPA policy. Always use the full resource path for the network and set `peering_mode` to `PRIVATE_SERVICE_ACCESS` to meet compliance.

## How to Use

1. Update your Terraform resource to include a compliant `networks` block (see **c.tf** above).
2. Run:

   ```bash
   terraform plan -out=plan.json
   ```
3. Check compliance with OPA:

   ```bash
     opa eval  --data ./policies/gcp  --input inputs\gcp\backupdr\plan\backup_rules\rule_id\plan.json  --format pretty  "data.terraform.gcp.security.backupdr.backup_plan.rule_id.message"
   ```
   <img width="779" alt="image" src="https://github.com/user-attachments/assets/5870aa91-0965-45be-834c-8019c66c6eda" />

   ```bash
   opa eval --data ./policies/gcp --input ./inputs\gcp\backupdr\management_server\network\peering_mode\plan.json  --format pretty  "data.terraform.gcp.security.backupdr.management_server.peering_mode.details"
   ```
   <img width="718" alt="image" src="https://github.com/user-attachments/assets/e3192322-1f8a-441e-bd1e-7ed3ebc7aae0" />


   
4. Fix any reported violations before applying your changes.

---

> **🚀 Pro tip:** Always specify the full network resource path and set `peering_mode` to `PRIVATE_SERVICE_ACCESS` to ensure your management server can communicate securely via Private Service Access.
