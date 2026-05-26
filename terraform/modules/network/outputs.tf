# =====================================
# FILE: terraform/modules/network/outputs.tf
# VERSION: v5-enterprise-disposable-final
# =====================================

# =====================================
# VIRTUAL NETWORK
# =====================================

output "vnet_id" {

  description = "Virtual Network ID"

  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {

  description = "Virtual Network Name"

  value = azurerm_virtual_network.vnet.name
}

output "vnet_address_space" {

  description = "Virtual Network Address Space"

  value = azurerm_virtual_network.vnet.address_space
}

# =====================================
# AKS SUBNET
# =====================================

output "subnet_id" {

  description = "AKS Subnet ID"

  value = azurerm_subnet.aks_subnet.id
}

output "subnet_name" {

  description = "AKS Subnet Name"

  value = azurerm_subnet.aks_subnet.name
}

output "subnet_address_prefixes" {

  description = "AKS Subnet Address Prefixes"

  value = azurerm_subnet.aks_subnet.address_prefixes
}

# =====================================
# ENTERPRISE NETWORK OUTPUTS
# =====================================

output "resource_group_name" {

  description = "Network Resource Group Name"

  value = var.resource_group_name
}

output "location" {

  description = "Azure Region"

  value = var.location
}