package terraform.gcp.security.clouddns.dns_policy.enable_logging 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.clouddns.dns_policy.vars

attribute_path := "enable_logging" 
compliant_values := true

summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)