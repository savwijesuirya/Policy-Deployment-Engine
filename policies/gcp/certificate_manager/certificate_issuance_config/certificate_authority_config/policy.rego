package terraform.gcp.security.certificate_manager.certificate_issuance_config.certificate_authority_config

import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.certificate_issuance_config.vars

conditions := [
  [
    {
      "situation_description": "Certificate authority config must use the correct CA pool.",
      "remedies": [
        "Set 'certificate_authority_service_config.ca_pool' to 'correctcarpool'"
      ]
    },
    {
      "condition": "Ensure the CA pool is configured with the correct value",
      "attribute_path": ["certificate_authority_config"],
      "values": [[
        {
          "certificate_authority_service_config": [
            {
              "ca_pool": "correctcarpool"
            }
          ]
        }
      ]],
      "policy_type": "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
