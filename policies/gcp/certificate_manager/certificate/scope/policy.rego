package terraform.gcp.security.certificate_manager.certificate.scope

import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.certificate.vars

conditions := [
  [
    {
      "situation_description": "Certificate 'scope' must be set to 'CLIENT_AUTH' only.",
      "remedies": [
        "Set the 'scope' attribute to 'CLIENT_AUTH'"
      ]
    },
    {
      "condition": "Ensure the 'scope' value is exactly 'CLIENT_AUTH'",
      "attribute_path": ["scope"],
      "values": ["CLIENT_AUTH"],
      "policy_type": "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
