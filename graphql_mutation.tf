# ---------------------------------------------------------
# GraphQL Mutation: Dependency Proxy Packages Settings
# Ref: https://docs.gitlab.com/api/graphql/reference/#mutationupdatedependencyproxypackagessettings
# Ref: https://docs.gitlab.com/api/graphql/reference/#dependencyproxypackagessetting
# ---------------------------------------------------------

resource "graphql_mutation" "dependency_proxy_packages_setting" {
  # Variables that will be used in GraphQL mutations
  mutation_variables = {
    enabled                  = var.enabled
    mavenExternalRegistryUrl = var.maven_external_registry_url
  }

  # Data, received in response of the resource mutation.
  compute_mutation_keys = {
    enabled                  = "data.updateDependencyProxyPackagesSettings.dependencyProxyPackagesSetting.enabled"
    mavenExternalRegistryUrl = "data.updateDependencyProxyPackagesSettings.dependencyProxyPackagesSetting.mavenExternalRegistryUrl"
  }

  # See https://registry.terraform.io/providers/sullivtr/graphql/latest/docs/resources/mutation#compute_from_create-1
  compute_from_create = true

  create_mutation = <<-EOT
    mutation CreateDependencyProxyPackagesSettings(
      $enabled: Boolean!, 
      $mavenExternalRegistryUrl: String,
    ) {
      updateDependencyProxyPackagesSettings(input: {
        projectPath: "${var.full_path}",
        enabled: $enabled,
        mavenExternalRegistryUrl: $mavenExternalRegistryUrl,
      }) {
        dependencyProxyPackagesSetting {
          enabled
          mavenExternalRegistryUrl
        }
        errors
      }
    }
  EOT

  # The same mutation (updateDependencyProxyPackagesSettings) used for both
  # create_mutation and update_mutation.
  update_mutation = <<-EOT
    mutation UpdateDependencyProxyPackagesSettings(
      $enabled: Boolean!, 
      $mavenExternalRegistryUrl: String,
    ) {
      updateDependencyProxyPackagesSettings(input: {
        projectPath: "${var.full_path}",
        enabled: $enabled,
        mavenExternalRegistryUrl: $mavenExternalRegistryUrl,
      }) {
        dependencyProxyPackagesSetting {
          enabled
          mavenExternalRegistryUrl
        }
        errors
      }
    }
  EOT

  # delete_mutation is a mutation that will be run on resource deletion (e.g. on terraform destroy).
  # The trick is that's the same mutation updateDependencyProxyPackagesSettings, but with hardcoded
  # `enabled: false` parameter. So effectivelly, resource deletion will turn off
  # the Dependency proxy for packages in GitLab project's settings.
  delete_mutation = <<-EOT
    mutation DeleteDependencyProxyPackagesSettings() {
      updateDependencyProxyPackagesSettings(input: {
        projectPath: "${var.full_path}",
        enabled: false,
      }) {
        dependencyProxyPackagesSetting {
          enabled
        }
        errors
      }
    }
  EOT

  # read_query is used to query the api resource after it has been created.
  read_query = <<-EOT
    query {
      project(fullPath: "${var.full_path}") {
        dependencyProxyPackagesSetting {
          enabled
          mavenExternalRegistryUrl
        }
      }
    }
  EOT
}
