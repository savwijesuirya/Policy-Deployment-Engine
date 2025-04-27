


    # package terraform.gcp.security.cloud_vmware_engine.external_access_rule.block_ssh

    # import data.terraform.gcp.security.cloud_vmware_engine.external_access_rule.vars as vars
    # import data.terraform.gcp.helpers 

    # non_compliant(resource) if {
    #     resource.values.action == "ALLOW"
    #     some i in resource.values.source_ip_ranges
    #     i.ip_address_range == "0.0.0.0/0"
    # }

    # non_compliant(resource) if {
    #     resource.values.action == "ALLOW"
    #     some j in resource.values.destination_ip_ranges
    #     j.ip_address_range == "0.0.0.0/0"
    # }

    # non_compliant(resource) if {
    #     resource.values.action == "ALLOW"
    #     some p in resource.values.source_ports
    #     p == "*"
    # }

    # non_compliant(resource) if {
    #     resource.values.action == "ALLOW"
    #     some q in resource.values.destination_ports
    #     q == "*"
    # }

    # custom_compliant(resource) = true if {
    #     not non_compliant(resource)
    # }

    # custom_compliant(resource) = false if {
    #     non_compliant(resource)
    # }

    # nc_resources := helpers.get_nc_resources(vars.resource_type, "custom_validation", false) if {
    #     [resource | 
    #         resource := input.planned_values.root_module.resources[_]
    #         resource.type == vars.resource_type
    #         custom_compliant(resource) == false
    #     ]
    # }

    # violations :=helpers.get_violations(vars.resource_type, "custom_validation", false, vars.friendly_resource_name)

    # summary := helpers.get_summary(vars.resource_type, "custom_validation", false, vars.friendly_resource_name)
package terraform.gcp.security.cloud_vmware_engine.external_access_rule.block_ssh

import data.terraform.gcp.helpers
import data.terraform.gcp.security.cloud_vmware_engine.external_access_rule.vars as vars

# Check for multiple compliance aspects
non_compliant(resource) if {
    resource.values.action == "ALLOW"
    some i in resource.values.source_ip_ranges
    i.ip_address_range == "0.0.0.0/0"
}

non_compliant(resource) if {
    resource.values.action == "ALLOW"
    some j in resource.values.destination_ip_ranges
    j.ip_address_range == "0.0.0.0/0"
}

non_compliant(resource) if {
    resource.values.action == "ALLOW"
    some p in resource.values.source_ports
    p == "*"
}

non_compliant(resource) if {
    resource.values.action == "ALLOW"
    some q in resource.values.destination_ports
    q == "*"
}

# Aggregate all compliance checks
custom_compliant(resource) = true if {
    not non_compliant(resource)
}
custom_compliant(resource) = false if {
    non_compliant(resource)
}

# Get non-compliant resources using multiple attribute checks
nc_resources_source_ip := helpers.get_nc_resources(vars.resource_type, "source_ip_ranges", ["0.0.0.0/0"])
nc_resources_dest_ip := helpers.get_nc_resources(vars.resource_type, "destination_ip_ranges", ["0.0.0.0/0"])
nc_resources_source_port := helpers.get_nc_resources(vars.resource_type, "source_ports", ["*"])
nc_resources_dest_port := helpers.get_nc_resources(vars.resource_type, "destination_ports", ["*"])

# Combine all violations
v1 := helpers.get_violations(vars.resource_type, "source_ip_ranges", ["0.0.0.0/0"], vars.friendly_resource_name)
v2 := helpers.get_violations(vars.resource_type, "destination_ip_ranges", ["0.0.0.0/0"], vars.friendly_resource_name)
v3 := helpers.get_violations(vars.resource_type, "source_ports", ["*"], vars.friendly_resource_name)
v4 := helpers.get_violations(vars.resource_type, "destination_ports", ["*"], vars.friendly_resource_name)

combined_violations := array.concat(array.concat(v1, v2), array.concat(v3, v4))


# Filter unique resources and create final summary
unique_resources := {resource.name | resource := input.planned_values.root_module.resources[_]; non_compliant(resource)}

summary := {
    "message": array.concat(
        [
            sprintf("Total %s detected: %d", [vars.friendly_resource_name, count(helpers.get_all_resources(vars.resource_type))]),
            sprintf("Non-compliant %s: %d/%d", [vars.friendly_resource_name, count(unique_resources), count(helpers.get_all_resources(vars.resource_type))])
        ],
        combined_violations
    )
}