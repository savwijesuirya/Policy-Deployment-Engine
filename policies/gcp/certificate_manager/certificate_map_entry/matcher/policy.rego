package terraform.gcp.security.certificate_manager.certificate_map_entry.matcher# Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.certificate_manager.certificate_map_entry.vars

attribute_path := "matcher"
compliant_values := ["SNI"]


summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)