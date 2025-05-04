package terraform.gcp.security.os_config.os_policy_assignment.rollout_state
import data.terraform.gcp.helpers
import data.terraform.gcp.security.os_config.os_policy_assignment.rollout_state.vars

# This policy ensures that OS Policy Assignments have a proper rollout configuration
# to ensure controlled and safe deployment of OS policies

conditions := [
    [
    {"situation_description" : "OS Policy Assignment does not have a rollout configuration",
    "remedies":[ "Configure a rollout strategy for the OS Policy Assignment to ensure controlled deployment"]},
    {
        "condition": "Check if rollout is defined",
        "attribute_path" : ["rollout"],
        "values" : [null],
        "policy_type" : "blacklist"
    }
    ],
    [
    {"situation_description" : "OS Policy Assignment has a disruption budget that is too high",
    "remedies":[ "Set a lower disruption budget to minimize impact during rollout"]},
    {
        "condition": "Check if disruption_budget is set to a reasonable percentage",
        "attribute_path" : ["rollout", "disruption_budget", "percent"],
        "values" : [null, 20],
        "policy_type" : "range"
    }
    ],
    [
    {"situation_description" : "OS Policy Assignment does not have minimum wait duration between rollout steps",
    "remedies":[ "Configure a minimum wait duration to ensure gradual and controlled rollout"]},
    {
        "condition": "Check if min_wait_duration is defined",
        "attribute_path" : ["rollout", "min_wait_duration"],
        "values" : [""],
        "policy_type" : "blacklist"
    }
    ]
]

# Displays a general message about policy compliance
message := helpers.get_multi_summary(conditions, vars.variables).message

# Displays a detailed summary of each resources compliance to every condition and situation
details := helpers.get_multi_summary(conditions, vars.variables).details