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
  }
}

provider "azurerm" {
  features {}
}

# =====================================
# Kubernetes Provider
# Uses local kubeconfig + kubelogin
# =====================================

provider "kubernetes" {

  config_path = "~/.kube/config"
}

# =====================================
# Helm Provider
# Uses local kubeconfig + kubelogin
# =====================================

provider "helm" {

  kubernetes {

    config_path = "~/.kube/config"
  }
}