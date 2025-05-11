# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_certificate_manager_certificate_issuance_config" "nc" {
    project = "issuance_config_keyalgorithmntest"
    name = "incorrectissuancecofnig"
     certificate_authority_config {
    certificate_authority_service_config {
        ca_pool = "incorrectcarpool" 
    }
     }
  lifetime = "1814400s"
  rotation_window_percentage = 34
  key_algorithm = "RSA_2048"
}