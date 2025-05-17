package terraform.gcp.security.certificate_manager.certificate.managed

import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.certificate.vars

conditions := [
  [
    {
      "situation_description": "Managed certificate must have correct domain, issuance config, and no DNS authorizations.",
      "remedies": [
        "Set domains to ['correctfilelocation']",
        "Ensure dns_authorizations is null",
        "Set issuance_config to 'correctissuance'"
      ]
    },
    {
      "condition": "Enforce allowed values for managed certificate attributes",
      "attribute_path": ["managed"],
      "values": [[
        {
          "domains": ["correctfilelocation"],
          "dns_authorizations": null,
          "issuance_config": "correctissuance"
        }
      ]],
      "policy_type": "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
