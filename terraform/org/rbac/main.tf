terraform {
  required_version = ">= 0.12.24"

  required_providers {
    google = "~> 3.16.0"
  }

  backend "gcs" {}
}

provider "google" {}

module "identities" {
  source = "../../modules/identity"
}

# data "terraform_remote_state" "org" {
#   backend = "gcs"
#   config = {
#     bucket = "${local.domain}-terraform-state"
#     prefix = "terraform/state/org-structure"
#   }
# }

# TODO: once Terraform v0.13 lands, consider looping over the module calls

module "org-admins" {
  source   = "../../modules/rbac"
  members  = [module.identities.groups.org-admin]
  roles    = module.identities.roles.org-admins
  resource = module.identities.org.id
}

module "admins" {
  source   = "../../modules/rbac"
  members  = [module.identities.groups.admin]
  roles    = module.identities.roles.admins
  resource = module.identities.org.id
  # resource = data.terraform_remote_state.org.id
}

module "devops" {
  source   = "../../modules/rbac"
  members  = [module.identities.groups.devops]
  roles    = module.identities.roles.devops
  resource = module.identities.org.id
  # resource = data.terraform_remote_state.org.id
}

module "developers" {
  source   = "../../modules/rbac"
  members  = [module.identities.groups.developers]
  roles    = module.identities.roles.developers
  resource = module.identities.org.id
  # resource = data.terraform_remote_state.org.id
}


module "security" {
  source   = "../../modules/rbac"
  members  = [module.identities.groups.security-admins]
  roles    = module.identities.roles.security-admins
  resource = module.identities.org.id
  # resource = data.terraform_remote_state.org.id
}

module "network" {
  source   = "../../modules/rbac"
  members  = [module.identities.groups.network-admins]
  roles    = module.identities.roles.network-admins
  resource = module.identities.org.id
  # resource = data.terraform_remote_state.org.id
}

module "readonly" {
  source   = "../../modules/rbac"
  members  = [module.identities.groups.readonly]
  roles    = module.identities.roles.readonly
  resource = module.identities.org.id
  # resource = data.terraform_remote_state.org.id
}