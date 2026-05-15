output "vnet_id" {

  description = "Virtual Network ID"

  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {

  description = "Virtual Network Name"

  value = azurerm_virtual_network.vnet.name
}

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