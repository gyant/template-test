# RBAC module

This is a simple module that maps members (users, service account, or groups) to roles, via the non-authoritative `google_folder_iam_binding` resource. Supports both org- and folder-level associations.

## Usage

```hcl
module "devops" {
  source   = "../../modules/rbac"
  members  = ["user:me@example.com"]
  roles    = ["roles/viewer"]
  resource = "folders/12345678"
  }
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| members | Identities (user, serviceAccount, group) to associate with roles | `list` | n/a | yes |
| resource | GCP org ID or folder where permissions should be mapped | `string` | n/a | yes |
| roles | Roles to associate | `list` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->