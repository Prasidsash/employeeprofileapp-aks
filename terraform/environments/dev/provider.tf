terraform {

  required_version = ">= 1.5.0"

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    # =====================================
    # TEMPORARILY DISABLED
    # Kubernetes Provider
    # Disabled during AKS bootstrap phase
    # =====================================

    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = "~> 2.30"
    # }

    # =====================================
    # TEMPORARILY DISABLED
    # Helm Provider
    # Disabled during AKS bootstrap phase
    # =====================================

    # helm = {
    #   source  = "hashicorp/helm"
    #   version = "~> 2.13"
    # }
  }
}

# =====================================
# Azure Provider
# Used for:
# - Resource Group
# - VNET
# - AKS
# - Monitoring
# =====================================

provider "azurerm" {
  features {}
}

# =====================================
# TEMPORARILY DISABLED
# Kubernetes Provider
#
# Azure DevOps hosted agent does not
# have kubeconfig before AKS creation.
#
# Causes:
# localhost:8080 connection refused
#
# Re-enable AFTER AKS creation.
# =====================================

# provider "kubernetes" {
#
#   config_path = "~/.kube/config"
# }

# =====================================
# TEMPORARILY DISABLED
# Helm Provider
#
# Requires AKS kubeconfig.
#
# Re-enable during:
# - App CD pipeline
# - Helm deployment stage
# =====================================

# provider "helm" {
#
#   kubernetes {
#
#     config_path = "~/.kube/config"
#   }
# }