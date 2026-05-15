# =====================================
# VIRTUAL NETWORK
# =====================================

resource "azurerm_virtual_network" "vnet" {

  name = var.vnet_name

  address_space = var.vnet_address_space

  location = var.location

  resource_group_name = var.resource_group_name

  tags = {

    environment = var.environment

    managed_by = "terraform"

    project = "employeeprofileapp"
  }
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
  # Optional Future Enhancements
  # Preserve Existing Behavior
  # =====================================

  service_endpoints = []

}