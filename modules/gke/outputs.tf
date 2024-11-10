output "client_key" {
  value = google_container_cluster.primary.master_auth.0.client_key
  description = "Client key for GKE cluster"
}

output "cluster_ca_certificate" {
  value = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
  description = "CA certificate for GKE cluster"
}

output "endpoint" {
  value = google_container_cluster.primary.endpoint
  description = "The endpoint for the GKE cluster"
}
# In modules/gke/main.tf (if not already there)
output "cluster_id" {
  value = google_container_cluster.primary.id
}

output "cluster_master_version" {
  value = google_container_cluster.primary.master_version
}

output "client_certificate" {
  value = google_container_cluster.primary.master_auth.0.client_certificate
}
