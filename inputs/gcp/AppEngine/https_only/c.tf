resource "google_app_engine_standard_app_version" "c" {
  service    = "default"
  runtime    = "python39"
  entrypoint {
    shell = "echo Hello World"
  }
  deployment {
    
  }
     inbound_services = ["INBOUND_SERVICE_HTTPS"]

  service_account = "projects/my-project/serviceAccounts/my-service-account@my-project.iam.gserviceaccount.com"
}
