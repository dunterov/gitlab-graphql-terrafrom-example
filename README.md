# Terraform + GitLab GraphQL example

This micro project demonstrates how to manage **GitLab resources using Terraform and GraphQL**.

The [official GitLab Terraform provider](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs)
is powerful, but it does not always expose every GitLab feature as an available Terraform
resource. In such cases, we can use the [`sullivtr/graphql`](https://registry.terraform.io/providers/sullivtr/graphql/latest)
provider to interact directly with GitLab's [GraphQL API](https://docs.gitlab.com/api/graphql/).

---

## Why GraphQL?

The GitLab provider does not yet support every resource. At the same time almost everything can be
configured with GraphQL. [GraphQL](https://graphql.org/) is a query language and runtime for APIs
that lets clients request exactly the data they need, and nothing more.
It's an alternative to REST, often more efficient and flexible.

---

## What this project does

- Configures [**GitLab Dependency proxy for packages settings**](https://docs.gitlab.com/user/packages/package_registry/dependency_proxy/)
    for a given project.
- Uses [**GraphQL mutations**](https://docs.gitlab.com/api/graphql/reference/) and queries
    to enable/disable and configure external Maven registry support.
- Provides an example pattern for extending Terraform beyond official providers.

---

## Usage

1. Create [Personal access token](https://docs.gitlab.com/user/profile/personal_access_tokens/).

2. Configure required variables (via `terraform.tfvars` file or CLI):

   ```hcl
   gitlab_base_url = "https://gitlab.com"
   gitlab_token    = "<your-token>"
   full_path       = "group/project"
   ```

2. Initialize Terraform:

   ```sh
   terraform init
   ```

3. Apply changes:

   ```sh
   terraform apply
   ```
