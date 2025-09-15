resource "google_artifact_registry_repository" "nc" {
  repository_id = "nc"
  format        = "GO"
  location      = "AU"

project = "artifact_registry_testing"


}