resource "google_artifact_registry_repository" "nc" {
  repository_id = "go-repo-nc"
  format        = "GO"
  location      = "AU"

project = "artifact_registry_testing"


}