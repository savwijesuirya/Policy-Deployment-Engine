# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_certificate_manager_certificate" "c" {
name = "certificatemanagertestlocation1-c" 
location = "australia-southeast1"
project = "fake-policy-test-project"
managed {
  domains = ["test.example.com"]
}
}
