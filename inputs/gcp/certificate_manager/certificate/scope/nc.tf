# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_certificate_manager_certificate" "nc" {
  name = "certificatemanagertest1-nc"
  location = "AU"
  scope = "DEFAULT"
  project = "fake-policy-test-project"
  managed {
  domains = ["test.example.com"]
}
}