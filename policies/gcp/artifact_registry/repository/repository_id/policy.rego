package terraform.gcp.security.artifact_registry.repository.repository_id

import data.terraform.gcp.helpers
import data.terraform.gcp.security.artifact_registry.repository.vars

conditions := [[
   {
        "situation_description": "Not Using Approved Repository IDs ",
        "remedies": [
            "use only approved repository IDs from the organisation "
        ]
    },
    {
        "condition": "Disallow repository IDs not approved by the organisation",
        "attribute_path": ["repository_id"],
        "values": ["c"],
        "policy_type": "whitelist"
    }
]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details