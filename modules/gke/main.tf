provider "google" {
  alias       = "gke"
  credentials = file("~/ingenio-task-gke/gke-demo/iac-terraform/eli-tamsut-devops-assessment-e1dc29958dcc.json")
  project     = var.project_id
  region      = var.region
}

# Default Google Provider for general resources
provider "google" {
  project = var.project_id
  region  = var.region
}


# GKE Cluster Resource (HA setup)
resource "google_container_cluster" "primary" {
  provider = google
  name     = "${var.project_id}-gke"
  location = var.region  # This is now a regional cluster for high availability (multi-master)

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.vpc_subnet.name

  enable_kubernetes_alpha = false

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "All"
    }
  }
}

# GKE Node Pool Resource (HA setup with nodes across multiple zones)
resource "google_container_node_pool" "primary_nodes" {
  provider = google
  name     = "primary-node-pool"
  location = var.region  # Node pool location across multiple zones
  cluster  = google_container_cluster.primary.name

  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    machine_type = "n2-standard-4"
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }

    disk_size_gb = 100
  }

  # Spread nodes across multiple zones (High Availability)
  node_locations = [
    "me-west1-a",
    "me-west1-b",
    "me-west1-c"
  ]

  management {
    auto_upgrade = true
    auto_repair  = true
  }
}

# Output GKE Cluster Information
output "gke_cluster_name" {
  value = google_container_cluster.primary.name
}

output "gke_cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "gke_cluster_master_version" {
  value = google_container_cluster.primary.master_version
}
