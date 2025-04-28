package terraform.gcp.security.analysis.note.expiration_note # Edit here 
import data.terraform.gcp.helpers
import data.terraform.gcp.security.analysis.note.vars

attribute_path := "expiration_time" 
compliant_values := ["2026-04-26T23:59:59Z"]

summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)