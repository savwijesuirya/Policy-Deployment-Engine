package terraform.gcp.security.backupdr.backup_plan.backup_vault

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.backup_plan.vars

attribute_path := "backup_vault"

compliant_values := [
    "projects/my-project-id/locations/australia-southeast1/backupVaults/approved-vault",
]

summary := helpers.get_summary(
    vars.resource_type,
    attribute_path,
    compliant_values,
    vars.friendly_resource_name,
)