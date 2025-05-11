# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_certificate_manager_certificate" "nc" {
  name = "projecttest1-nc"
  location = "AU"
  scope = "DEFAULT"
  project = "incorrectfake-policy-test-project"
  managed {
    
  domains =  ["incorrectfilelocation"]
  dns_authorizations = ["inCorrectdns"]
  issuance_config = null
  }
 
  
}
