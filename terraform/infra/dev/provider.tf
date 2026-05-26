# =====================================
# FILE: terraform/infra/dev/provider.tf
# VERSION: v3-enterprise-disposable-final
# =====================================

terraform {

  required_version = ">= 1.5.0"

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.11"
    }
  }

  backend "azurerm" {}
}

# =====================================
# CURRENT AZURE CLIENT CONFIG
# =====================================

data "azurerm_client_config" "current" {}

# =====================================
# AZURE PROVIDER
# Enterprise OIDC Authentication
# =====================================

provider "azurerm" {

  features {

    key_vault {

      purge_soft_delete_on_destroy = true

      recover_soft_deleted_key_vaults = true
    }

    resource_group {

      prevent_deletion_if_contains_resources = false
    }
  }

  use_oidc = true

  use_cli = false

  storage_use_azuread = true
}

# =====================================
# KUBERNETES PROVIDER
# Enterprise Stable AKS Authentication
# =====================================

provider "kubernetes" {

  host = module.aks.host

  client_certificate = base64decode(
    module.aks.client_certificate
  )

  client_key = base64decode(
    module.aks.client_key
  )

  cluster_ca_certificate = base64decode(
    module.aks.cluster_ca_certificate
  )
}

# =====================================
# HELM PROVIDER
# Enterprise Stable AKS Authentication
# =====================================

provider "helm" {

  kubernetes {

    host = module.aks.host

    client_certificate = base64decode(
      module.aks.client_certificate
    )

    client_key = base64decode(
      module.aks.client_key
    )

    cluster_ca_certificate = base64decode(
      module.aks.cluster_ca_certificate
    )
  }
}

# =====================================
# KUBECTL PROVIDER
# Enterprise Stable AKS Authentication
# =====================================

provider "kubectl" {

  host = module.aks.host

  client_certificate = base64decode(
    module.aks.client_certificate
  )

  client_key = base64decode(
    module.aks.client_key
  )

  cluster_ca_certificate = base64decode(
    module.aks.cluster_ca_certificate
  )

  load_config_file = false
}

# =====================================
# OPTIONAL FUTURE PROVIDER NOTES
# =====================================

# Future enterprise enhancements may include:
#
# - Workload Identity authentication
# - OIDC federation
# - Terraform Cloud integration
# - Remote execution runners
# - Multi-environment provider aliasing
# - Dedicated provider aliases
# - UAMI-based Terraform execution
# - Federated credential execution model
#
# Current provider model intentionally
# preserves stable AKS + Helm behavior
# while enabling enterprise OIDC readiness.