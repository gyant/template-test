
variable "members" {
  description = "Identities (user, serviceAccount, group) to associate with roles"
  type        = list
}

variable "roles" {
  description = "Roles to associate"
  type        = list
}

variable "resource" {
  description = "GCP org ID or folder where permissions should be mapped"
  type        = string
}

locals {
  is_org = length(regexall("^folders/", var.resource)) == 0 ? true : false
}

resource "google_folder_iam_binding" "admin" {
  for_each = local.is_org ? [] : toset(var.roles)
  folder   = var.resource
  role     = each.key
  members  = var.members
}

resource "google_organization_iam_binding" "binding" {
  for_each = local.is_org ? toset(var.roles) : []
  org_id   = var.resource
  role     = each.key
  members  = var.members
}