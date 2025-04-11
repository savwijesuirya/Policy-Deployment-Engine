# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_data_loss_prevention_discovery_config" "nc" {
    parent = "projects/my-project-name/locations/us"
    location = "us"
    status = "RUNNING"

}