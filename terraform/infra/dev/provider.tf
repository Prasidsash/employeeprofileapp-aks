# =====================================
# FILE: terraform/infra/dev/provider.tf
# VERSION: v4-enterprise-stable-final
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
}

# =====================================
# CURRENT AZURE CLIENT CONFIG
# =====================================

data "azurerm_client_config" "current" {}

# =====================================
# AZURE PROVIDER
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
}

# =====================================
# KUBERNETES PROVIDER
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