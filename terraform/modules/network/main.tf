# =====================================
# FILE: terraform/modules/network/main.tf
# VERSION: v5-enterprise-disposable-final
# =====================================

# =====================================
# VIRTUAL NETWORK
# =====================================

resource "azurerm_virtual_network" "vnet" {

  name = var.vnet_name

  address_space = var.vnet_address_space

  location = var.location

  resource_group_name = var.resource_group_name

  tags = merge(

    {
      environment = var.environment

      managed_by = "terraform"

      project = "employeeprofileapp"

      module = "network"
    },

    var.additional_tags
  )
}

# =====================================
# AKS SUBNET
# =====================================

resource "azurerm_subnet" "aks_subnet" {

  name = var.aks_subnet_name

  resource_group_name = var.resource_group_name

  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = var.aks_subnet_prefixes

  # =====================================
  # OPTIONAL FUTURE ENHANCEMENTS
  # =====================================

  service_endpoints = var.service_endpoints

  private_endpoint_network_policies = "Enabled"

  private_link_service_network_policies_enabled = true
}