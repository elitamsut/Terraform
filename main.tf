terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "bucketeli"
    key    = "terraform/terraform.tfstate"
    region = "me-west1"
  }
}

provider "google" {
  credentials = file("~/ingenio-task-gke/gke-demo/iac-terraform/eli-tamsut-devops-assessment-e1dc29958dcc.json")
  project     = "eli-tamsut-devops-assessment"
  region      = "me-west1"
  zone        = "me-west-a"
}



# VPC - https://registry.terraform.io/providers/hashicorp/google/4.74.0/docs/resources/compute_network
resource "google_compute_network" "vpc" {
  name        = var.vpc_name
  description = var.vpc_description

  # the network is created in "custom subnet mode"
  # we will explicitly connect subnetwork resources below using google_compute_subnetwork resource
  auto_create_subnetworks = "false"
}

# Subnet - https://registry.terraform.io/providers/hashicorp/google/4.74.0/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  description   = var.subnet_description
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.cidrBlock
}
