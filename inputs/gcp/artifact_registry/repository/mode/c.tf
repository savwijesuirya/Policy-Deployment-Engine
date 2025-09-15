# The mode field determines how artifacts are retrieved or served from the repository. 
# Limiting all repos to STANDARD_REPOSITORY ensures central control, traceability, and scanning.

resource "google_artifact_registry_repository" "c" {
  repository_id = "c"
  format        = "DOCKER"
  location      = "AU"
  mode          = "STANDARD_REPOSITORY"

project = "artifact_registry_testing"

}
