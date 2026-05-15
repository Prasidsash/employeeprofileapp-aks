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

# =====================================
# AKS MANAGED IDENTITY
# =====================================

output "aks_principal_id" {

  description = "AKS Managed Identity Principal ID"

  value = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

output "aks_tenant_id" {

  description = "AKS Managed Identity Tenant ID"

  value = azurerm_kubernetes_cluster.aks.identity[0].tenant_id
}

# =====================================
# KUBELET IDENTITY
# =====================================

output "kubelet_identity_object_id" {

  description = "AKS Kubelet Identity Object ID"

  value = try(
    azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id,
    null
  )
}

output "kubelet_identity_client_id" {

  description = "AKS Kubelet Identity Client ID"

  value = try(
    azurerm_kubernetes_cluster.aks.kubelet_identity[0].client_id,
    null
  )
}

# =====================================
# OPTIONAL FUTURE OIDC SUPPORT
# =====================================

output "oidc_issuer_url" {

  description = "AKS OIDC Issuer URL"

  value = try(
    azurerm_kubernetes_cluster.aks.oidc_issuer_url,
    null
  )
}

# =====================================
# KUBECONFIG DETAILS
# =====================================

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