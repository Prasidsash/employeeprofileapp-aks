output "cluster_name" {

  description = "AKS Cluster Name"

  value = azurerm_kubernetes_cluster.aks.name
}

output "cluster_id" {

  description = "AKS Cluster ID"

  value = azurerm_kubernetes_cluster.aks.id
}

output "node_resource_group" {

  description = "AKS Node Resource Group"

  value = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "kubernetes_version" {

  description = "AKS Kubernetes Version"

  value = azurerm_kubernetes_cluster.aks.kubernetes_version
}

output "host" {

  value = azurerm_kubernetes_cluster.aks.kube_config[0].host

  sensitive = true
}

output "client_certificate" {

  value = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate

  sensitive = true
}

output "client_key" {

  value = azurerm_kubernetes_cluster.aks.kube_config[0].client_key

  sensitive = true
}

output "cluster_ca_certificate" {

  value = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate

  sensitive = true
}