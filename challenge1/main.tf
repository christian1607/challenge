
provider "google" {
     //credentials = file("sa-credentials.json")
}

variable "cluster_name" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
}

resource "google_container_cluster" "gke" {
  name     = var.cluster_name
  location = "us-central1-a"
  

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "nodepool" {
  name       = "my-node-pool"
  location   = "us-central1-a"
  cluster    = google_container_cluster.gke.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}