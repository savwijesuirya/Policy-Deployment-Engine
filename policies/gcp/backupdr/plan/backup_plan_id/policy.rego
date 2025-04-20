package terraform.gcp.security.backupdr.backup_plan.backup_plan_id # Edit here

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

attribute_path := "backup_plan_id" # Edit here (eg., "storage_class")
compliant_values := [
    "compliant-plan-id",
]

summary := {
    "message": [
        sprintf("Total %s detected: %v", [vars.friendly_resource_name, count(helpers.get_all_resources(vars.resource_type))]),
        sprintf("Non-compliant %s: %v/%v", [vars.friendly_resource_name, count(helpers.get_nc_resources(vars.resource_type, attribute_path, compliant_values)), count(helpers.get_all_resources(vars.resource_type))])
    ]
}