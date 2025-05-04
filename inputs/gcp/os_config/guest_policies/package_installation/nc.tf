# Non-compliant OS Config Guest Policy without proper package installation configuration
# This resource is missing package resources and assignment targets

resource "google_os_config_guest_policies" "nc" {
  provider = google-beta
  project = "pde-s224021028"
  guest_policy_id = "guest-policy-non-compliant"
  description     = "Non-compliant guest policy missing package resources"
  
  assignment {
    # Missing group_labels
    
    # Missing os_types - not specifying which OS this applies to
    
    # No instances defined
    
    # Zones with incorrect locations
    zones = ["us-central1-a", "us-central1-b"]  # Non-compliant: Missing comma separator
  }
  
  # The absence of these blocks makes this resource non-compliant
  # A proper guest policy should define what packages to install and where to apply the policy
}