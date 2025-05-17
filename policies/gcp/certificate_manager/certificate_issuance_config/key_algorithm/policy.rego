package terraform.gcp.security.certificate_manager.certificate_issuance_config.key_algorithm

import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.certificate_issuance_config.vars

conditions := [
  [
    {
      "situation_description": "Key algorithm must be ECDSA_P256.",
      "remedies": [
        "Set 'key_algorithm' to 'ECDSA_P256'"
      ]
    },
    {
      "condition": "Check if 'key_algorithm' is set to 'ECDSA_P256'",
      "attribute_path": ["key_algorithm"],
      "values": ["ECDSA_P256"],
      "policy_type": "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
