# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_data_loss_prevention_discovery_config" "c" {
    parent = "projects/my-project-name/locations/us"
    location = "au"
    status = "RUNNING"

}
