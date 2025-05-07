package terraform.gcp.security.backupdr.management_server.peering_mode  # Edit here
import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.management_server.vars

conditions := [
  [
    {
      "situation_description": "Peering mode must be PRIVATE_SERVICE_ACCESS",
      "remedies": [
        "Set `peering_mode` to `PRIVATE_SERVICE_ACCESS`"
      ]
    },
    {
      "condition":      "peering_mode not in approved list",
      "attribute_path": ["values","networks",0,"peering_mode"],
      "values":         ["PRIVATE_SERVICE_ACCESS"],
      "policy_type":    "whitelist"
    }
  ]
]

# general summary
message := helpers.get_multi_summary(conditions, vars.variables).message

# detailed per-resource compliance
details := helpers.get_multi_summary(conditions, vars.variables).details
