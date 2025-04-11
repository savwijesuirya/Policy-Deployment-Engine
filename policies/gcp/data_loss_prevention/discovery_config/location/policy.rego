package terraform.gcp.security.data_loss_prevention.discovery_config.location # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.data_loss_prevention.discovery_config.vars

attribute_path := "location" # Edit here (eg., "storage_class")
compliant_values := [
    "au"
]

summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)