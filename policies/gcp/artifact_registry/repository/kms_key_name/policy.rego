package terraform.gcp.security.artifact_registry.repository.kms_key_name

import data.terraform.gcp.helpers
import data.terraform.gcp.security.artifact_registry.repository.vars

conditions := [[
  {
    "situation_description": "This specific Repository requires the use of KMS Key!",
    "remedies": [
      " utalise an approved kms_key_name in the repository configuration to enable encryption."
      ]
  },
  {
    "condition": "Repository's With Valid KMS Keys are regarded as compliant",
    "attribute_path": ["kms_key_name"],
    "values": ["projects/artifact_registry_testing/locations/australia-southeast1/keyRings/my-keyring/cryptoKeys/my-key"],
    "policy_type": "whitelist"
  }
]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details