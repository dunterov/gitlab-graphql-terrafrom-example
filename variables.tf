# ---------------------------------------------------------
# Input Variables
# ---------------------------------------------------------

variable "full_path" {
  type        = string
  description = "The full path of the GitLab project (e.g., 'group/project')."
}

variable "maven_external_registry_url" {
  type        = string
  description = "External Maven registry URL used for dependency proxy packages."
  default     = "https://repo.maven.apache.org/maven2/"
}

variable "enabled" {
  type        = bool
  description = "Flag to enable or disable dependency proxy packages setting."
  default     = true
}

variable "gitlab_base_url" {
  type        = string
  description = "Base URL of the GitLab instance (e.g., 'https://gitlab.com' or your on-prem url)."
}

variable "gitlab_token" {
  type        = string
  description = "Personal access token used for authentication with GitLab."
  sensitive   = true
}
