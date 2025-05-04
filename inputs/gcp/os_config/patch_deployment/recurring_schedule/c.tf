# Compliant OS Config Patch Deployment with proper recurring schedule
# This resource has a recurring schedule configured to run weekly

resource "google_os_config_patch_deployment" "c" {
  project = "pde-s224021028"
  patch_deployment_id = "patch-deploy-compliant"
  description         = "Compliant patch deployment with weekly schedule"
  
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
  
  recurring_schedule {
    time_zone {
      id = "Australia/Melbourne"
    }
    
    time_of_day {
      hours = 2
      minutes = 30
      seconds = 0
      nanos = 0
    }
    
    weekly {
      day_of_week = "MONDAY"
    }
  }
}