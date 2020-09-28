terraform {
  required_version = ">= 0.12.24"
}

variable "org_selection" {
  description = "Which GCP org to use (allows testing in another gsuite org)"
  default     = "foghorn"
}

variable "orgs" {
  description = "Foghorn Consulting GCP organziation"
  default = {
    "foghorn" = {
      "name"            = "foghornconsuting.com",
      "domain"          = "foghornconsuting.com",
      "id"              = "42918743314",
      "shared_services" = "602426154568"
    }
  }
}

locals {
  org = {
    name            = var.orgs[var.org_selection].name
    id              = var.orgs[var.org_selection].id
    domain          = var.orgs[var.org_selection].domain
    shared_services = var.orgs[var.org_selection].shared_services
  }

  groups = {
    foghorn = "group:allfoghorn@${local.org.domain}"

    org-admins      = "group:gcp-organization-admins@${local.org.domain}"
    admins          = "group:gcp-admins@${local.org.domain}"
    devops          = "group:gcp-devops@${local.org.domain}"
    developers      = "group:gcp-developers@${local.org.domain}"
    security-admins = "group:gcp-security-admins@${local.org.domain}"
    network-admins  = "group:gcp-network-admins@${local.org.domain}"
    readonly        = "group:gcp-readonly@${local.org.domain}"
  }
}

output "groups" {
  value = local.groups
}

output "org" {
  value = local.org
}