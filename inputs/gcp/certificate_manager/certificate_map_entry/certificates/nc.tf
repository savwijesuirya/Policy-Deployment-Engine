# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant
resource "google_certificate_manager_certificate_map_entry" "nc" {
    name = "cert-map-entry-noncompliant"
    project = "projectcertificatemapentry"
    certificates = ["incorrectcertificate"]
    map = "correctmapentry"
    matcher ="Primary"
}
