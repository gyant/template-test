resource "google_compute_network" "vpc" {
  name = "network"

  auto_create_subnetworks         = false
  delete_default_routes_on_create = false
}

resource "google_compute_subnetwork" "us-west1" {
  name          = "us-west1"
  region        = "us-west1"
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.2.0.0/16"
}
