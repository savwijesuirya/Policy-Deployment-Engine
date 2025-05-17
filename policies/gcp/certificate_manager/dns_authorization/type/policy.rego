package terraform.gcp.security.certificate_manager.dns_authorization.type # Edit here

import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.dns_authorization.vars

conditions := [
  [
    {
      "situation_description": "The DNS authorization type is not set to 'PER_PROJECT_RECORD'.",
      "remedies": [
        "Update the resource 'type' attribute to 'PER_PROJECT_RECORD'"
      ]
    },
    {
      "condition": "Check if the resource type is 'PER_PROJECT_RECORD'",
      "attribute_path": ["type"],
      "values": ["PER_PROJECT_RECORD"],
      "policy_type": "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
