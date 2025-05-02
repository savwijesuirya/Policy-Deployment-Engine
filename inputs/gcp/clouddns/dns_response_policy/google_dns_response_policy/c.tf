# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_compute_network" "c" {
    name = "network-1"
    project = "create_subnet"
    auto_create_subnetworks = false
}
