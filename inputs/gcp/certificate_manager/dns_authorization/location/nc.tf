# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_certificate_manager_dns_authorization" "nc" {
    name = "dns_authorization_nc"
    domain = "test.example.com"
    project = "fake-policy-test-project"
    location = ""


}
