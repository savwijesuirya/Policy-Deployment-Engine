

resource "google_artifact_registry_repository" "c" {
  repository_id = "c"
  format        = "DOCKER"
  location      = "AU"

project = "artifact_registry_testing"

}

