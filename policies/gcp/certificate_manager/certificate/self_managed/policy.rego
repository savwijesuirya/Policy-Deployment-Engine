package terraform.gcp.security.certificate_manager.certificate.self_managed

import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.certificate.vars

conditions := [
  [
    {
      "situation_description": "Self-managed certificate must have the correct PEM fields and null others.",
      "remedies": [
        "Set 'pem_certificate' to 'fileofcertificatepermissions'",
        "Set 'pem_private_key' to 'fileofprivatekey'",
        "Ensure 'certificate_pem' and 'private_key_pem' are null"
      ]
    },
    {
      "condition": "Ensure only allowed values for self-managed certificate attributes",
      "attribute_path": ["self_managed"],
      "values": [[
        {
          "pem_certificate": "fileofcertificatepermissions",
          "pem_private_key": "fileofprivatekey",
          "certificate_pem": null,
          "private_key_pem": null
        }
      ]],
      "policy_type": "whitelist"
    }
  ]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
