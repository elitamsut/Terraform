# Provider Configuration with Credentials for GKE (Aliased)
provider "google" {
  alias       = "gke"
  credentials = file("~/ingenio-task-gke/gke-demo/iac-terraform/eli-tamsut-devops-assessment-e1dc29958dcc.json")
  project     = var.project_id
  region      = var.region
}

# Default Google Provider for General Resources (without credentials)
provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  project                 = var.project_id   # Make sure project_id is referenced here
  auto_create_subnetworks = "false"
}


resource "google_compute_subnetwork" "subnet" {
  provider = google.gke
  project  = var.project_id  # Use the project_id variable
  name     = var.subnet_name
  region   = var.region
  network  = google_compute_network.vpc.name
  ip_cidr_range = var.cidrBlock
}
