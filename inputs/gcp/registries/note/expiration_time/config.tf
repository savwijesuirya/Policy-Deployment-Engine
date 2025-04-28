##### DO NOT EDIT ######

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project     = "mock-project-id"  # Use a mock project ID for local testing
  region      = "us-central1"      # Specify the region for simulation
}