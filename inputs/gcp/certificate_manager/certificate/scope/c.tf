# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_certificate_manager_certificate" "c" {
name = "certificatemanagertest1-c" 

scope = "CLIENT_AUTH"
project = "fake-policy-test-project"
managed {
  domains = ["test.example.com"]
  dns_authorizations = ["correctfilelocation"]
}
}
