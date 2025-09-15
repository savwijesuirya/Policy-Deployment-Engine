
resource "google_artifact_registry_repository" "nc" {
  repository_id = "nc"
  format        = "DOCKER"
  location      = "AU"

project = "artifact_registry_testing"


}
