# =====================================
# AKS CLUSTER
# =====================================

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
# OPTIONAL AKS FQDN
# =====================================

output "aks_fqdn" {

  description = "AKS API Server FQDN"

  value = try(
    azurerm_kubernetes_cluster.aks.fqdn,
    null
  )
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
# OPTIONAL FUTURE WORKLOAD IDENTITY
# =====================================

output "workload_identity_enabled" {

  description = "AKS Workload Identity Enabled"

  value = try(
    azurerm_kubernetes_cluster.aks.workload_identity_enabled,
    null
  )
}

# =====================================
# KUBECONFIG DETAILS
# =====================================

output "host" {

  description = "AKS API Server Host"

  value = azurerm_kubernetes_cluster.aks.kube_config[0].host

  sensitive = true
}

output "client_certificate" {

  description = "AKS Client Certificate"

  value = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate

  sensitive = true
}

output "client_key" {

  description = "AKS Client Key"

  value = azurerm_kubernetes_cluster.aks.kube_config[0].client_key

  sensitive = true
}

output "cluster_ca_certificate" {

  description = "AKS Cluster CA Certificate"

  value = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate

  sensitive = true
}