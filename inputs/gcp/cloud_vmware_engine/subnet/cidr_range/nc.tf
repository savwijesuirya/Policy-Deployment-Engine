# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant

resource "google_vmwareengine_network" "subnet-nw_nc" {
  name        = "pc-nw"
  location    = "global"
  type        = "STANDARD"
  description = "PC network description."
}

resource "google_vmwareengine_private_cloud" "subnet-pc_nc" {
  location    = "us-west1-a"
  name        = "sample-pc"
  description = "Sample test PC."
  network_config {
    management_cidr       = "10.0.0.0/24"
    vmware_engine_network = google_vmwareengine_network.subnet-nw_nc.id
  }

  management_cluster {
    cluster_id = "sample-mgmt-cluster"
    node_type_configs {
      node_type_id = "standard-72"
      node_count   = 3
    }
  }
}

resource "google_vmwareengine_subnet" "nc" {
  name = "service-1"
  parent =  google_vmwareengine_private_cloud.subnet-pc_nc.id
  ip_cidr_range = "10.0.0.0/26"
}