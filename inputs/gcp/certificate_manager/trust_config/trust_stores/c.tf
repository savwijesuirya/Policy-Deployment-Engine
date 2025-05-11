# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_certificate_manager_trust_config" "c" {
  name        = "trust_config_compliant"
  project = "trust_config_truststores_test"
  location = "AU"

 trust_stores {
    trust_anchors { 
      pem_certificate = "validsecurecertificate"
    }
    intermediate_cas { 
      pem_certificate = "validsecurecertificate"
    }
  }
}
