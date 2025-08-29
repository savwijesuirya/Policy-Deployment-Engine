

resource "google_artifact_registry_repository_iam_member" "nc" {
  repository = "unsecuresecure-repo"
  location   = "AU"
  project    = "your-project-id"
  role       = "roles/artifactregistry.reader"
  member     = "user:hacker@gmail.com"
}
