terraform {
  required_version = ">= 0.12.24"

  required_providers {
    google = "~> 3.16.0"
  }

  backend "gcs" {
    bucket = "<STATE_BUCKET_NAME>"
    prefix = "terraform/state/projects/network"
  }
}

provider "google" {
  project = data.terraform_remote_state.org.projects.network.project_id
}

data "terraform_remote_state" "org" {
  backend = "gcs"
  config = {
    bucket = "<STATE_BUCKET_NAME>"
    prefix = "terraform/state/org"
  }
}
