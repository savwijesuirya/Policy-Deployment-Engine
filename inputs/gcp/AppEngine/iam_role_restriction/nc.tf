resource "google_app_engine_standard_app_version" "nc" {
  service    = "default"
  runtime    = "python39"
  deployment {
    
  }
  entrypoint {
    shell = "echo Hello World"
  }
  service_account = "projects/my-project/serviceAccounts/default@appspot.gserviceaccount.com"
}
