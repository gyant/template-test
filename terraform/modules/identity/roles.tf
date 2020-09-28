
variable "standard_groups" {
  default = [
    "gcp-organization-admins",
    "gcp-admins", # non-org-admin ... administrators
    "gcp-network-admins",
    "gcp-security-admins",
    "gcp-billing-admins",
    "gcp-devops",
    "gcp-readonly",
  ]
}

variable "org_admin_roles" {
  description = "Roles for Organization administrators"
  default = [
    "roles/billing.admin",
    "roles/iam.organizationRoleAdmin",
    "roles/orgpolicy.policyAdmin",
    "roles/owner",
    "roles/resourcemanager.organizationAdmin",
    "roles/resourcemanager.projectCreator",
    "roles/resourcemanager.projectDeleter"
  ]
}

variable "admin_roles" {
  description = "Roles for non-org administrators"
  default = [
    "roles/billing.projectManager",
    "roles/compute.admin",
    "roles/compute.networkAdmin",
    "roles/compute.xpnAdmin",
    "roles/container.admin",
    "roles/resourcemanager.folderAdmin",
    "roles/browser",
    "roles/resourcemanager.projectCreator",
    "roles/resourcemanager.projectDeleter",
  ]
}

variable "admin_roles_org_level" {
  description = "Org-level roles for (non-org) admins (TODO: do we need these?)"
  default = [
    "roles/billing.user",
    "roles/billing.viewer",
    "roles/iam.organizationRoleViewer",
  ]
}

variable "devops_roles" {
  description = "Roles for devops teams"
  default = [
    "roles/cloudbuild.builds.editor",
    "roles/compute.instanceAdmin.v1",
    "roles/compute.networkUser",
    "roles/container.admin",
    "roles/resourcemanager.folderViewer",
    "roles/source.admin"
  ]
}

variable "developer_roles" {
  description = "Roles for developer teams"
  default = [
    "roles/cloudbuild.builds.editor",
    "roles/compute.instanceAdmin.v1",
    "roles/compute.networkUser",
    "roles/container.admin",
    "roles/viewer",
    "roles/source.admin",
  ]
}

output "roles" {
  description = "Roles associated with each group"
  value = {
    org-admins      = var.org_admin_roles
    admins          = var.admin_roles
    devops          = var.devops_roles
    developers      = var.developer_roles
    security-admins = ["roles/compute.securityAdmin"]
    network-admins  = ["roles/compute.networkAdmin"]
    readonly        = ["roles/viewer"]
  }
}
