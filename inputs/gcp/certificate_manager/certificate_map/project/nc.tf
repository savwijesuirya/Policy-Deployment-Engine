# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant
resource "google_certificate_manager_certificate_map" "nc" {
    name = "certificate_maptestnoncompliant"
    project = "incorrectprojectlocation"
}
