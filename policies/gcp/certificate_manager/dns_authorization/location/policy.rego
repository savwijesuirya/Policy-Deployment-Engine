package terraform.gcp.security.certificate_manager.dns_authorization.location # Edit here

import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.dns_authorization.vars

conditions := [
  [
    {
      "situation_description": "The DNS authorization resource is not located in the approved region.",
      "remedies": [
        "Update the resource to be located in 'AU'"
      ]
    },
    {
      "condition": "Check if the resource's location is 'AU'",
      "attribute_path": ["location"],
      "values": ["AU"],
      "policy_type": "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
