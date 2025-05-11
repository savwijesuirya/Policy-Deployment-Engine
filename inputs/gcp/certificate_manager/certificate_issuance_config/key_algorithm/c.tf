# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_certificate_manager_certificate_issuance_config" "c" {
    
    project = "issuance_config_keyalgorithmntest"
    name = "correctissuancecofnig"
     certificate_authority_config {
    certificate_authority_service_config {
        ca_pool = "correctcarpool" 
    }
     }
  lifetime = "1814400s"
  rotation_window_percentage = 34
  key_algorithm = "ECDSA_P256"
}
