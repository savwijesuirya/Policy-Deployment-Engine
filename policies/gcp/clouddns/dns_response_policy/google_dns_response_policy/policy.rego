package terraform.gcp.security.clouddns.dns_response_policy.google_dns_response_policy # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.clouddns.dns_response_policy.vars

attribute_path := "google_dns_response_policy"
compliant_values := false


summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)