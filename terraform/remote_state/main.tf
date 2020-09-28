terraform {
  required_version = ">= 0.12.24"

  required_providers {
    google = "~> 3.16.0"
  }
}

provider "google" {}

variable "org_name" {
  default = "example.com"
}

data "google_organization" "org" {
  domain = var.org_name
}

resource "google_project" "service-a" {
  name            = "Service A"
  project_id      = "service-a"
  org_id          = data.google_organization.org.org_id
  billing_account = data.google_billing_account.acct.id
}

resource "google_storage_bucket" "state-bucket" {
  name               = "example-com-terraform-state"
  location           = "US"
  force_destroy      = false
  bucket_policy_only = true
}

resource "google_storage_bucket_iam_binding" "storage-admin" {
  bucket = google_storage_bucket.state-bucket.name
  role   = "roles/storage.admin"
  members = [
    "group:devops@example.com",
  ]
}
