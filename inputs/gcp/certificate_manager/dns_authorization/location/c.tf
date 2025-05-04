# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_certificate_manager_dns_authorization" "c" {
    name = "dns_authorization_compliant"
    domain = "test.example.com"
    project = "fake-policy-test-project"
    location = "AU"


}
