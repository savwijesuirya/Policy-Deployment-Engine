# Compliant OS Config Guest Policy with proper package installation configuration
# This resource has package resources defined and uses secure repositories

resource "google_os_config_guest_policies" "c" {
  provider = google-beta
  project = "pde-s224021028"
  guest_policy_id = "guest-policy-compliant"
  description     = "Compliant guest policy with secure package installation"
  
  package_repositories {
    apt {
      uri          = "https://packages.cloud.google.com/apt"
      archive_type = "DEB"
      distribution = "cloud-sdk"
      components   = ["main"]
    }
  }
  
  packages {
    name          = "google-cloud-sdk"
    desired_state = "INSTALLED"
  }
  
  packages {
    name          = "kubectl"
    desired_state = "INSTALLED"
  }
  
  assignment {
    group_labels {
      labels = {
        env = "prod"
      }
    }
    
    os_types {
      os_short_name = "debian"
      os_version    = "10"
    }
    
    instances = ["zones/australia-southeast1-a/instances/test-instance"]
    
    zones = ["australia-southeast1-a", "australia-southeast1-b", "australia-southeast2-a", "australia-southeast2-b"]
  }
}