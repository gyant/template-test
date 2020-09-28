terraform {
  required_version = ">= 0.12.24"

  required_providers {
    google = "~> 3.16.0"
  }

  backend "gcs" {
    bucket = "<STATE_BUCKET_NAME>"
    prefix = "terraform/state/projects/service-a"
  }
}

provider "google" {
  project = data.terraform_remote_state.org.projects.service-a.project_id
}

data "terraform_remote_state" "org" {
  backend = "gcs"
  config = {
    bucket = "<STATE_BUCKET_NAME>"
    prefix = "terraform/state/org"
  }
}

data "terraform_remote_state" "network" {
  backend = "gcs"
  config = {
    bucket = "<STATE_BUCKET_NAME>"
    prefix = "terraform/state/projects/network"
  }
}

resource "google_compute_instance" "service-a" {
  name         = "service-a"
  machine_type = "n1-standard-1"
  zone         = "us-west1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = data.terraform_remote_state.network.subnets.us-west1.id

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
