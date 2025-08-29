package terraform.gcp.security.artifact_registry.repository.mode

import data.terraform.gcp.helpers
import data.terraform.gcp.security.artifact_registry.repository.vars

conditions := [[
   {
        "situation_description": "Repository mode is not set to STANDARD_REPOSITORY",
        "remedies": [
            "Use mode = STANDARD_REPOSITORY to enforce consistent behavior and better security."
        ]
    },
    {
        "condition": "Disallow repository modes other than STANDARD_REPOSITORY.",
        "attribute_path": ["mode"],
        "values": ["STANDARD_REPOSITORY"],
        "policy_type": "whitelist"
    }
]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
details := helpers.get_multi_summary(conditions, vars.variables).details