package terraform.gcp.security.artifact_registry.repository_iam.restrict_external_members

import data.terraform.gcp.helpers
import data.terraform.gcp.security.artifact_registry.repository_iam.vars

conditions := [

  # Situation 1: Block public access
  [
    {
      "situation_description": "only users with authentication user: and with organisation approved email can utalise this resource .",
      "remedies": [
        "Do not assign roles to allUsers or allAuthenticatedUsers.",
        "Use specific users, groups, or service accounts instead."
      ]
    },
    {
      "condition": "Block public IAM members.",
      "attribute_path": ["member"],
      "values": ["user:employee@your-company.com"],
      "policy_type": "whitelist"
    }
  ],

 ]


message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details