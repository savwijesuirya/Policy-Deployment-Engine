package terraform.gcp.security.os_config.guest_policies.package_installation
import data.terraform.gcp.helpers
import data.terraform.gcp.security.os_config.guest_policies.package_installation.vars

# This policy ensures that guest policies have proper package installation configurations
# to ensure security and compliance of installed packages

conditions := [
    [
    {"situation_description" : "Guest policy does not have package resources defined",
    "remedies":[ "Define package resources in the guest policy to manage software installations"]},
    {
        "condition": "Check if package_resources is defined",
        "attribute_path" : ["package_resources"],
        "values" : [null],
        "policy_type" : "blacklist"
    }
    ],
    [
    {"situation_description" : "Guest policy allows installation of packages from insecure sources",
    "remedies":[ "Ensure all package installations use secure repositories or verified sources"]},
    {
        "condition": "Check if package repositories are secure",
        "attribute_path" : ["package_repositories", "apt", "archive_type"],
        "values" : ["DEB"],
        "policy_type" : "whitelist"
    }
    ],
    [
    {"situation_description" : "Guest policy does not specify assignment targets",
    "remedies":[ "Define specific assignment targets for the guest policy to control which instances it applies to"]},
    {
        "condition": "Check if assignment is defined",
        "attribute_path" : ["assignment", "zones"],
        "values" : ["us-central1-a", "us-central1-b"],
        "policy_type" : "blacklist"
    }
    ]
]

# Displays a general message about policy compliance
message := helpers.get_multi_summary(conditions, vars.variables).message

# Displays a detailed summary of each resources compliance to every condition and situation
details := helpers.get_multi_summary(conditions, vars.variables).details