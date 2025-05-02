# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_dns_policy" "c" {
    name = "networks"
    project = "network_policy"
    networks{
        network_url = ""
    }
}
