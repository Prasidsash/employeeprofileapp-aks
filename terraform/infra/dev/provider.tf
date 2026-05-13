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

    time = {
      source  = "hashicorp/time"
      version = "~> 0.11"
    }
  }
}

provider "azurerm" {

  features {}
}

# =====================================
# AKS DATA SOURCE
# =====================================

data "azurerm_kubernetes_cluster" "aks" {

  name = var.cluster_name

  resource_group_name = var.resource_group_name

  depends_on = [
    module.aks
  ]
}

# =====================================
# KUBERNETES PROVIDER
# =====================================

provider "kubernetes" {

  host = data.azurerm_kubernetes_cluster.aks.kube_config[0].host

  client_certificate = base64decode(
    data.azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  )

  client_key = base64decode(
    data.azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  )

  cluster_ca_certificate = base64decode(
    data.azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  )
}

# =====================================
# HELM PROVIDER
# =====================================

provider "helm" {

  kubernetes {

    host = data.azurerm_kubernetes_cluster.aks.kube_config[0].host

    client_certificate = base64decode(
      data.azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
    )

    client_key = base64decode(
      data.azurerm_kubernetes_cluster.aks.kube_config[0].client_key
    )

    cluster_ca_certificate = base64decode(
      data.azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
    )
  }
}