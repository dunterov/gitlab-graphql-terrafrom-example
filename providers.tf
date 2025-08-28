# ---------------------------------------------------------
# Providers configuration
# ---------------------------------------------------------

provider "graphql" {
  url = "${var.gitlab_base_url}/api/graphql"
  headers = {
    Authorization = "Bearer ${var.gitlab_token}"
    Content-Type  = "application/json"
  }
}

provider "gitlab" {
  token    = var.gitlab_token
  base_url = var.gitlab_base_url
}
