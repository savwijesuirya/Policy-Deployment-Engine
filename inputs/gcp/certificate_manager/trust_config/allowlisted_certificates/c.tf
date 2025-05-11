# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_certificate_manager_trust_config" "c" {
  name        = "trust_config_compliant"
  project = "trust_config_allowlisted_test"
  location = "AU"

  allowlisted_certificates  {
    pem_certificate = "Allowedcertificate"
  }
}
