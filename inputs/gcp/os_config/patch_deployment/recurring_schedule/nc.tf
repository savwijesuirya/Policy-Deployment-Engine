# Non-compliant OS Config Patch Deployment without a recurring schedule
# This resource is missing a recurring schedule configuration

resource "google_os_config_patch_deployment" "nc" {
  project = "pde-s224021028"
  patch_deployment_id = "patch-deploy-non-compliant"
  description         = "Non-compliant patch deployment without recurring schedule"
  
  instance_filter {
    all = true
  }
  
  patch_config {
    apt {
      type = "DIST"
      excludes = ["python-*"]
    }
    
    yum {
      security = true
      minimal = true
      excludes = ["bash-*"]
    }
    
    goo {
      enabled = true
    }
    
    zypper {
      categories = ["security"]
    }
    
    windows_update {
      classifications = ["CRITICAL", "SECURITY"]
    }
    
    pre_step {
      linux_exec_step_config {
        allowed_success_codes = [0]
        local_path = "/tmp/pre_patch_script.sh"
      }
    }
    
    post_step {
      linux_exec_step_config {
        allowed_success_codes = [0]
        local_path = "/tmp/post_patch_script.sh"
      }
    }
  }
  
  # Missing recurring_schedule block makes this non-compliant
  # A one_time_schedule is not sufficient for regular patching
  one_time_schedule {
    execute_time = "2023-10-25T15:30:00Z"
  }
}