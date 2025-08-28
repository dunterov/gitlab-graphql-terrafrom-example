# ---------------------------------------------------------
# Root Terraform configuration
# ---------------------------------------------------------

terraform {
  required_providers {
    graphql = {
      source  = "sullivtr/graphql"
      version = "2.6.1"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 18"
    }
  }
}
