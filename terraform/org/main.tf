terraform {
  required_version = ">= 0.12.24"

  required_providers {
    google = "~> 3.16.0"
  }

  backend "gcs" {
    bucket = "<STATE_BUCKET_NAME>"
    prefix = "terraform/state/org"
  }
}

provider "google" {}

data "google_organization" "org" {
  domain = var.org_name
}

data "google_billing_account" "acct" {
  billing_account = "<BILLING_ACCOUNT_ID>"
  open            = true
}
