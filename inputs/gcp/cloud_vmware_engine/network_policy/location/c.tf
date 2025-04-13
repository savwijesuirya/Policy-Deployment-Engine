# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant

resource "google_vmwareengine_network" "subnet-nw" {
  name        = "pc-nw"
  location    = "global"
  type        = "STANDARD"
  description = "PC network description."
}

resource "google_vmwareengine_private_cloud" "subnet-pc" {
  location    = "us-west1-a"
  name        = "sample-pc"
  description = "Sample test PC."
  network_config {
    management_cidr       = "192.168.50.0/24"
    vmware_engine_network = google_vmwareengine_network.subnet-nw.id
  }

  management_cluster {
    cluster_id = "sample-mgmt-cluster"
    node_type_configs {
      node_type_id = "standard-72"
      node_count   = 3
    }
  }
}

resource "google_vmwareengine_subnet" "c" {
  name = "service-1"
  parent =  google_vmwareengine_private_cloud.subnet-pc.id
  ip_cidr_range = "192.168.100.0/26"
}
