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
  project = "sit737-25t1-vartak-29a614e"
}