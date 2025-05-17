package terraform.gcp.security.certificate_manager.certificate.location # Edit here 

import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.certificate.vars
conditions := [
    [
        {
            "situation_description": "Certificate Manager location is not in an approved region.",
            "remedies": [ 
                "Use australia-southeast1 or AU as the location for your certificate.",
                "Ensure deployment meets geo-location compliance."
            ]
        },
        {
            "condition": "Location must be one of the allowed regions.",
            "attribute_path": ["location"],
            "values": ["australia-southeast1", "AU"],
            "policy_type": "whitelist"
        }
    ]
]

message := helpers.get_multi_summary(conditions, vars.variables).message
