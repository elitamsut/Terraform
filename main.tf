terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}


resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

provider "google" {
  credentials = file("~/ingenio-task-gke/gke-demo/iac-terraform/eli-tamsut-devops-assessment-e1dc29958dcc.json")
  project     = "eli-tamsut-devops-assessment"
  region      = "me-west1"
  zone        = "me-west-a"
}
