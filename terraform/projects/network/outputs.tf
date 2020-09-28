output "vpc" {
  value = google_compute_network.vpc
}

output "subnets" {
  value = {
    us-west1 = google_compute_subnetwork.us-west1
  }
}
