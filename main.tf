terraform {
  # Require Terraform 0.12
  required_version = ">= 0.12.7"
}

provider "google" {
  credentials = file("./gcproject-test-sa-tf.json")
  #this SA is for terraform, the other for px
  project     = var.project
  region      = var.location
}

resource "google_container_cluster" "default" {
  name        = var.name
  #name   = "my-poor-gke-cluster"
  project     = var.project
  description = "Demo GKE Cluster"
  location    = var.location
  min_master_version = 1.14

  # we too poor
  logging_service = "none"
  monitoring_service = "none"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count = var.initial_node_count

  # Setting an empty username and password explicitly disables basic auth
  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    tags = ["poor-cluster", "testing"]
  }

}

resource "google_container_node_pool" "default" {
  name       = var.name-node-pool
  #name       = "my-poor-node-pool"
  project     = var.project
  location   = var.location
  cluster    = google_container_cluster.default.name
  node_count = var.initial_node_count

  node_config {
    preemptible  = true
    machine_type = var.machine_type
    disk_size_gb = 10
    image_type = "ubuntu"
    metadata = {
      disable-legacy-endpoints = "true"
    }


    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  management {
    auto_repair = true
    auto_upgrade = false
  }

}


