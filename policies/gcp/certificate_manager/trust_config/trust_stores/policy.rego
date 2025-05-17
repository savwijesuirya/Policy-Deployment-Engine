package terraform.gcp.security.certificate_manager.trust_config.trust_stores

import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.trust_config.vars

conditions := [
  [
    {
      "situation_description": "Trust stores must include valid secure certificates in intermediate CAs and trust anchors",
      "remedies": [
        "Ensure intermediate CAs have 'validsecurecertificate' pem_certificate",
        "Ensure trust anchors have 'validsecurecertificate' pem_certificate"
      ]
    },
    {
      "condition": "Check intermediate_cas pem_certificate whitelist",
      "attribute_path": ["trust_stores", 0, "intermediate_cas", 0, "pem_certificate"],
      "values": ["validsecurecertificate"],
      "policy_type": "whitelist"
    }
  ],
  [
    {
      "situation_description": "Trust stores must include valid secure certificates in trust anchors",
      "remedies": [
        "Ensure trust anchors have 'validsecurecertificate' pem_certificate"
      ]
    },
    {
      "condition": "Check trust_anchors pem_certificate whitelist",
      "attribute_path": ["trust_stores", 0, "trust_anchors", 0, "pem_certificate"],
      "values": ["validsecurecertificate"],
      "policy_type": "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
