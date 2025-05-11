# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant
resource "google_certificate_manager_trust_config" "nc" {
  name        = "trust_config_noncompliant"
  project = "trust_config_allowlisted_test"
  location = "global"

  allowlisted_certificates  {
    pem_certificate = "Unallowedcertificate"
  }
}