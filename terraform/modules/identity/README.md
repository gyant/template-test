# Foghorn Standard for Google Cloud IAM

Standard groups and roles, modelled closely on GCP [best practices for enterprise organizations][gcp-bp].

[gcp-bp]: https://cloud.google.com/docs/enterprise/best-practices-for-enterprise-organizations
[gcp-roles]: https://cloud.google.com/iam/docs/understanding-roles

## Groups Rationale

The [GCP enterprise best practices][gcp-bp] provides brief descriptions of the recommended groups. We take a similar approach, but split billing admin roles between org-admins and non-org admins. Additionally, we add a read-only group. The following is a bit more context on what _roles_ we assign to each group. For an exhaustive list of GCP roles and their meanings, refer to [Understanding roles][gcp-roles] in the GCP docs.

| Name                    | Description                                                                                                                                                                                                                                          |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| gcp-organization-admins | Admin users that will possess the capabilities of changing org-level permissions and policies. Also possess the billing admin role.                                                                                                                  |
| gcp-admins              | Admin users intended to possess broad high-level permissions org-wide. Can assign or disable billing for a project, but cannot otherwise administer billing.                                                                                         |
| gcp-network-admins      | Network Operations staff intended for richer permission sets on networking-related containers. Has one very elevated role, `compute.networkAdmin` assigned, allowing administration of networking resources,  but not firewalls or SSL certificates. |
| gcp-security-admins     | Posses on role, `compute.securityAdmin`, allowing for administration of firewall rules and SSL certificates, as well as Shielded VMs.                                                                                                                |
| gcp-devops              | Permissions to manage compute, container, and code (Cloud Source Repositories) resources, as well as GCP folder viewer.                                                                                                                              |
| gcp-developers          | Developers using google cloud resources. Largely overlaps with the `gcp-devops` group in terms of permissions, but allows for further separation of responsibilities.                                                                                |
| gcp-readonly            | Purely read-only role (specifically, `roles/viewer`).                                                                                                                                                                                                |

## Usage

```hcl
module "identities" {
  source = "../../modules/identity"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name      | Version    |
| --------- | ---------- |
| terraform | >= 0.12.24 |

## Providers

No provider.

## Inputs

| Name                     | Description                                                    | Type     | Default                                                                                                                                                                                                                                                                                                                                     | Required |
| ------------------------ | -------------------------------------------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: |
| admin\_roles             | Roles for non-org administrators                               | `list`   | <pre>[<br>  "roles/billing.projectManager",<br>  "roles/compute.admin",<br>  "roles/compute.networkAdmin",<br>  "roles/compute.xpnAdmin",<br>  "roles/container.admin",<br>  "roles/resourcemanager.folderAdmin",<br>  "roles/browser",<br>  "roles/resourcemanager.projectCreator",<br>  "roles/resourcemanager.projectDeleter"<br>]</pre> |    no    |
| admin\_roles\_org\_level | Org-level roles for (non-org) admins (TODO: do we need these?) | `list`   | <pre>[<br>  "roles/billing.user",<br>  "roles/billing.viewer",<br>  "roles/iam.organizationRoleViewer"<br>]</pre>                                                                                                                                                                                                                           |    no    |
| developer\_roles         | Roles for developer teams                                      | `list`   | <pre>[<br>  "roles/cloudbuild.builds.editor",<br>  "roles/compute.instanceAdmin.v1",<br>  "roles/compute.networkUser",<br>  "roles/container.admin",<br>  "roles/viewer",<br>  "roles/source.admin"<br>]</pre>                                                                                                                              |    no    |
| devops\_roles            | Roles for devops teams                                         | `list`   | <pre>[<br>  "roles/cloudbuild.builds.editor",<br>  "roles/compute.instanceAdmin.v1",<br>  "roles/compute.networkUser",<br>  "roles/container.admin",<br>  "roles/resourcemanager.folderViewer",<br>  "roles/source.admin"<br>]</pre>                                                                                                        |    no    |
| org\_admin\_roles        | Roles for Organization administrators                          | `list`   | <pre>[<br>  "roles/billing.admin",<br>  "roles/iam.organizationRoleAdmin",<br>  "roles/orgpolicy.policyAdmin",<br>  "roles/owner",<br>  "roles/resourcemanager.organizationAdmin",<br>  "roles/resourcemanager.projectCreator",<br>  "roles/resourcemanager.projectDeleter"<br>]</pre>                                                      |    no    |
| org\_selection           | Which GCP org to use (allows testing in another gsuite org)    | `string` | `"foghorn"`                                                                                                                                                                                                                                                                                                                                 |    no    |
| orgs                     | Foghorn Consulting GCP organziation                            | `map`    | <pre>{<br>  "foghorn": {<br>    "domain": "foghornconsuting.com",<br>    "id": "42918743314",<br>    "name": "foghornconsuting.com",<br>    "shared_services": "602426154568"<br>  }<br>}</pre>                                                                                                                                             |    no    |
| standard\_groups         | n/a                                                            | `list`   | <pre>[<br>  "gcp-organization-admins",<br>  "gcp-admins",<br>  "gcp-network-admins",<br>  "gcp-security-admins",<br>  "gcp-billing-admins",<br>  "gcp-devops",<br>  "gcp-readonly"<br>]</pre>                                                                                                                                               |    no    |

## Outputs

| Name   | Description                      |
| ------ | -------------------------------- |
| groups | n/a                              |
| org    | n/a                              |
| roles  | Roles associated with each group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->