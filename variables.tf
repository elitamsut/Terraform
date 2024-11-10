variable "project_id" {
  description = "The project ID for GCP"
  type        = string
}

variable "region" {
  description = "The region to create the GKE cluster"
  default     = "me-west1"
}

variable "zones" {
  description = "The zones to create the GKE cluster"
  type        = list(string)
  default     = ["me-west1-a", "me-west1-b", "me-west1-c"]
}

variable "network" {
  description = "The network to be used for the GKE cluster"
  type        = string
  default     = "vpc-01"
}

variable "subnetwork" {
  description = "The subnetwork to be used for the GKE cluster"
  type        = string
  default     = "me-west1-01"
}

variable "ip_range_pods" {
  description = "The IP range for the GKE cluster pods"
  type        = string
  default     = "me-west1-01-gke-01-pods"
}

variable "ip_range_services" {
  description = "The IP range for the GKE cluster services"
  type        = string
  default     = "me-west1-01-gke-01-services"
}

variable "node_pool_machine_type" {
  description = "The machine type for the GKE node pool"
  type        = string
  default     = "e2-medium"
}

variable "node_pool_min_count" {
  description = "The minimum number of nodes in the node pool"
  type        = number
  default     = 1
}

variable "node_pool_max_count" {
  description = "The maximum number of nodes in the node pool"
  type        = number
  default     = 3
}

variable "node_pool_disk_size_gb" {
  description = "The disk size in GB for each node in the node pool"
  type        = number
  default     = 100
}

variable "node_pool_disk_type" {
  description = "The disk type for the GKE node pool"
  type        = string
  default     = "pd-standard"
}

variable "node_pool_image_type" {
  description = "The image type for the GKE node pool"
  type        = string
  default     = "COS_CONTAINERD"
}

variable "node_pool_service_account" {
  description = "The service account to be used by the GKE nodes"
  type        = string
}

variable "node_pool_auto_repair" {
  description = "Whether the GKE nodes should be automatically repaired"
  type        = bool
  default     = true
}

variable "node_pool_auto_upgrade" {
  description = "Whether the GKE nodes should be automatically upgraded"
  type        = bool
  default     = true
}

variable "preemptible" {
  description = "Whether the GKE nodes should be preemptible"
  type        = bool
  default     = false
}

