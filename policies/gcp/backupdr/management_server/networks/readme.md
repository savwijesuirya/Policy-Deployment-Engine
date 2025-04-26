# `networks` Attribute for `google_backup_dr_management_server`

This README explains the `networks` attribute block for the **GCP Backup & DR Management Server** (`google_backup_dr_management_server`) resource. It covers:

- What the attribute is for  
- How to configure it in Terraform  
- What constitutes **compliant** vs. **non-compliant** configurations  

---

## What is the `networks` Block?

The `networks` block tells Backup & DR which VPC network(s) your management server should use. Each block has two fields:

- **`network`** (Required):  
  Fully‐qualified Network URL in the form  
  ```
  projects/<PROJECT_ID>/global/networks/<NETWORK_NAME>
  ```
- **`peering_mode`** (Optional):  
  How the service peering should be established.  
  - Default: `PRIVATE_SERVICE_ACCESS`  
  - Allowed values: `PRIVATE_SERVICE_ACCESS`

---

## Compliance Policy

Our policy enforces that every `network` must be **fully qualified**. In particular, it must:

1. Start with  
   ```
   projects/<your-project-id>/global/networks/
   ```
2. Reference an existing VPC network in your project.

Any entry that omits the `projects/...` prefix or points outside your project will be flagged as non-compliant.

---

## Terraform Examples

### Compliant Example (`c.tf`)
```hcl
resource "google_backup_dr_management_server" "c" {
  name     = "ms-console"
  location = "australia-southeast1"
  project  = "policy-deployment-backups"
  type     = "BACKUP_RESTORE"

  networks = [{
    network      = "projects/policy-deployment-backups/global/networks/vpc-network"
    peering_mode = "PRIVATE_SERVICE_ACCESS"
  }]
}
```

### Non-Compliant Example (`nc.tf`)
```hcl
resource "google_backup_dr_management_server" "nc" {
  name     = "ms-console"
  location = "australia-southeast1"
  project  = "policy-deployment-backups"
  type     = "BACKUP_RESTORE"

  networks = [{
    # Missing the "projects/.../global/networks/" prefix
    network      = "vpc-network"
    peering_mode = "PRIVATE_SERVICE_ACCESS"
  }]
}
```

In the second example, the `network` value `"vpc-network"` will be caught by our OPA policy as non-compliant because it does not begin with the expected `projects/.../global/networks/` prefix.

---

## How to Use

1. Add your compliant block (as shown in **c.tf**) under `networks` in your Terraform resource.  
2. Run `terraform plan` → get a JSON plan.  
3. Evaluate with OPA to check compliance:
   ```bash
   opa eval --data ./policies/gcp --input ./plan.json --format pretty  "data.terraform.gcp.security.backupdr.management_server.networks.summary.message"
   ```
4. Fix any reported violations before applying.

---

> **🚀 Pro tip:** Keep your VPC network names consistent and always use the full resource path to avoid misconfiguration!
