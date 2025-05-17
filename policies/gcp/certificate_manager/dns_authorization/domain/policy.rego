package terraform.gcp.security.certificate_manager.dns_authorization.domain

import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.dns_authorization.vars

conditions := [
  [
    {
      "situation_description": "The DNS authorization domain is not configured to the expected value.",
      "remedies": [
        "Ensure the domain is set to 'https://test.example.com'"
      ]
    },
    {
      "condition": "Check if 'domain' is set to 'https://test.example.com'",
      "attribute_path": ["domain"],
      "values": ["test.example.com"],
      "policy_type": "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
