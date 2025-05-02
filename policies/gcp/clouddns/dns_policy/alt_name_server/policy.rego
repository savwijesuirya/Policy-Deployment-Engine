package terraform.gcp.security.clouddns.dns_policy.alt_name_server 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.clouddns.dns_policy.vars

attribute_path := "alt_name_server" 
compliant_values := ["139.0.0.1"]
    

summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)