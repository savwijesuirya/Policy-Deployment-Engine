# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_compute_network" "nc" {
    name = "network-1"
    project = "create_subnet"
    auto_create_subnetworks = true
}