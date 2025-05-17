package terraform.gcp.security.certificate_manager.trust_config.location

import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.trust_config.vars

conditions := [
  [
    {
      "situation_description": "Resource location must be AU",
      "remedies": ["Change the location to 'AU'"]
    },
    {
      "condition": "Test if location is AU",
      "attribute_path": ["location"],
      "values": ["AU"],
      "policy_type": "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
