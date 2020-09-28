# template-gcp
GCP Terraform Base Template

## Git Submodules

This repository makes use of [git submodules](https://git-scm.com/docs/git-submodule) to leverage the ability to create a general container repository while also maintaining individual module repo atomicity. If you're not familiar with git submodules, it's useful to think of them as symlinks for git repos. They allow us to set up directories in our repo that reference the contents of other repositories with the ability to do cool stuff like tag / branch pinning.

This change requires a bit of additional setup:

1. `git submodule init`
1. `git submodule update`

`update`can also be used any time the locally checked out code needs to sync with upstream changes:

1. Change the entry in `.gitmodules` to the new upstream reference:

    ```
    [submodule "terraform/modules/network"]
    path = terraform/modules/network
    url = git@github.com:FoghornConsulting/m-gcp-network.git
    branch = <new branch / tag here>
    ```

1. Run: `git submodule update --remote`

For fresh clones of the repository, it's easy to cover this in the clone itself:

```
git clone --recurse-submodules <git url here>
```

## Terraform Module References

In order to use the modules in this repository in other terraform environments, we need to structure the source string as follows:

```
module "<module name here>" {
  source = "git@github.com:FoghornConsulting/template-gcp.git//terraform/modules/<module name here>?ref=<branch / tag ref here>"
  ...
}
```

## Remote State

The `remote_state` environment contains a single project nested below the gcp organization. Its purpose is to stand up the storage bucket that contains the state of all other terraform environments.

This is the only environment that will have its tfstate committed to the repository.

To facilitate this, .gitignore has the following:

```
*.tfstate
*.tfstate.*
!remote_state/terraform.tfstate
```

## Org

Contents of this folder need to be run by users with elevated permissions for the entire organization. This includes: creating folders, projects, binding billing accounts to projects, setting org-level IAM permissions, and setting org policy constraints.

Outputs are very important for this terraform evironment. As folders and projects are added, they'll have to be included in `outputs.tf` for other terraform environments to reference them.

## Projects

Projects directory contain all the terraform environments for each individual project (without including the creation of the project itself).

This particular example has a `network` and `service-a` environment that shows the basic template for a shared vpc setup.

`service-a ` references the `network` environments remote state to pull in details about the vpc and subnetworks.

However, a project could contain both its own network and compute resources.