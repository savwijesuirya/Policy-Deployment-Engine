# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_certificate_manager_certificate" "nc" {
  name = "certificatemanagertestlocation1-nc"
  location = "global"
  project = "fake-policy-test-project"
  managed {
  domains = ["test.example.com"]
}
}