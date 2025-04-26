package terraform.gcp.security.backupdr.management_server.location

import data.terraform.gcp.helpers
import data.terraform.gcp.security.backupdr.management_server.vars

# The attribute path under the resource to check
attribute_path := "location"

# Only this location is approved
compliant_values := ["australia-southeast1"]


summary := helpers.get_summary(
    vars.resource_type,
    attribute_path,
    compliant_values,
    vars.friendly_resource_name,
)
