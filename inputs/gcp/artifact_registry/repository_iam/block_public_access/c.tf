# Disallow any binding to allUsers or allAuthenticatedUsers.
# Prevent allUsers or allAuthenticatedUsers from being granted access to repositories.

resource "google_artifact_registry_repository_iam_member" "c" {
  repository = "private-repo-c"
  location   = "AU"
  project    = "your-project-id"
  role       = "roles/artifactregistry.reader"
  member     = "user:validemployee@example.com"
}

