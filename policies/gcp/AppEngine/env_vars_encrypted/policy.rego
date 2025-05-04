package terraform.gcp.security.app_engine.env_vars_encrypted

import data.terraform.gcp.helpers
import data.terraform.gcp.security.app_engine.env_vars_encrypted.vars

attribute_path := "env_variables.SECRET_SOURCE"
compliant_values := [
  "projects/my-project/secrets/SECRET_NAME"
]

summary := helpers.get_summary(vars.resource_type, attribute_path, compliant_values, vars.friendly_resource_name)
