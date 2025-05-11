# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_certificate_manager_certificate" "nc" {
  name = "selfmanagedtest1-nc"
  location = "AU"
  scope = "DEFAULT"
  project = "fake-policy-test-project"
  
 self_managed {
    pem_certificate = "incorrectcertificatepemlocation"
    pem_private_key = "incorrectprivatekeylocation"
  }
}
  
