# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant
resource "google_certificate_manager_certificate_map_entry" "c" {
    name = "cert-map-entry-compliant"
    project = "projectcertificatemapentry"
    certificates = ["correctcertificate"]
    map = "correctmapentry"
    matcher ="SNI"
}
