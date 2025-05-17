package terraform.gcp.security.certificate_manager.trust_config.allowlisted_certificates

import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.trust_config.vars

# STEP 1: STUDY YOUR RESOURCE AND ITS ATTRIBUTES, THEN FILL IN THE VARS FILE

# STEP 2: CREATE SCENARIOS (simple whitelist for allowlisted_certificates)

conditions := [
  [
    {
      "situation_description": "Certificate is not in the allowlist",
      "remedies": [
        "Add the PEM certificate to the allowlisted_certificates",
        "Ensure only approved certificates are allowed"
      ]
    },
    {
      "condition": "Check if the allowlisted_certificates contains the allowed PEM certificate",
      "attribute_path": ["allowlisted_certificates", 0, "pem_certificate"],
      "values": ["Allowedcertificate"],
      "policy_type": "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
