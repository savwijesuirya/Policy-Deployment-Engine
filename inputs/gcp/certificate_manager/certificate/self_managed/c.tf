# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_certificate_manager_certificate" "c" {
name = "selfmanagedtest1-c" 
location = "AU"
scope = "CLIENT_AUTH"
project = "fake-policy-test-project"

self_managed {
    pem_certificate = "fileofcertificatepermissions"
    pem_private_key = "fileofprivatekey"
  }
}

