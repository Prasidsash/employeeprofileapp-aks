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
# AZURE PROVIDER
# =====================================

provider "azurerm" {

  features {

    key_vault {

      purge_soft_delete_on_destroy = true
    }
  }
}

# =====================================
# KUBERNETES PROVIDER
# Stable AKS Provider Authentication
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
# Stable AKS Provider Authentication
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
# Stable AKS Provider Authentication
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
#
# Current provider model intentionally
# preserves stable AKS + Helm behavior.