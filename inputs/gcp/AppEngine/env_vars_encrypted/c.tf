resource "google_app_engine_standard_app_version" "c" {
  service    = "default"
  runtime    = "python39"
  entrypoint {
    shell = "echo Hello World"
  }
  deployment {
    
  }
    env_variables = {
    SECRET_SOURCE = "projects/my-project/secrets/SECRET_NAME"
  }
  service_account = "projects/my-project/serviceAccounts/my-service-account@my-project.iam.gserviceaccount.com"
}
