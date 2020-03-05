resource "google_compute_network" "default" {
  name = "test-network"
  project = var.project
}

resource "google_compute_firewall" "default" {
  name    = "test-fw"
  network = google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = []
  }
  source_ranges = ["0.0.0.0/0"]
}