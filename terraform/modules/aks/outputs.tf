# =====================================
# FILE: terraform/modules/aks/outputs.tf
# VERSION: v5-enterprise-disposable-final
# =====================================

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

  value = try(
    azurerm_kubernetes_cluster.aks.identity[0].principal_id,
    null
  )
}

output "aks_tenant_id" {

  description = "AKS Managed Identity Tenant ID"

  value = try(
    azurerm_kubernetes_cluster.aks.identity[0].tenant_id,
    null
  )
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
# OIDC ISSUER
# =====================================

output "oidc_issuer_url" {

  description = "AKS OIDC Issuer URL"

  value = try(
    azurerm_kubernetes_cluster.aks.oidc_issuer_url,
    null
  )
}

# =====================================
# WORKLOAD IDENTITY
# =====================================

output "workload_identity_enabled" {

  description = "AKS Workload Identity Enabled"

  value = try(
    azurerm_kubernetes_cluster.aks.workload_identity_enabled,
    false
  )
}

# =====================================
# KEY VAULT CSI DRIVER
# =====================================

output "key_vault_secrets_provider_enabled" {

  description = "Azure Key Vault CSI Driver Enabled"

  value = var.enable_key_vault_secrets_provider
}

output "secret_rotation_enabled" {

  description = "Azure Key Vault Secret Rotation Enabled"

  value = var.secret_rotation_enabled
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

# =====================================
# USER ASSIGNED MANAGED IDENTITY
# =====================================

output "user_assigned_identity_ids" {

  description = "User Assigned Managed Identity IDs"

  value = try(
    azurerm_kubernetes_cluster.aks.identity[0].identity_ids,
    []
  )
}

# =====================================
# ENTERPRISE PIPELINE OUTPUTS
# =====================================

output "aks_kubelet_client_id" {

  description = "AKS Kubelet Identity Client ID"

  value = try(
    azurerm_kubernetes_cluster.aks.kubelet_identity[0].client_id,
    null
  )
}

output "aks_kubelet_object_id" {

  description = "AKS Kubelet Identity Object ID"

  value = try(
    azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id,
    null
  )
}

output "tenant_id" {

  description = "Azure Tenant ID"

  value = try(
    azurerm_kubernetes_cluster.aks.identity[0].tenant_id,
    null
  )
}

# =====================================
# ENTERPRISE WORKLOAD IDENTITY OUTPUTS
# =====================================

output "aks_oidc_issuer_url" {

  description = "AKS OIDC Issuer URL for Federated Credentials"

  value = try(
    azurerm_kubernetes_cluster.aks.oidc_issuer_url,
    null
  )
}

output "aks_workload_identity_enabled" {

  description = "AKS Workload Identity Status"

  value = try(
    azurerm_kubernetes_cluster.aks.workload_identity_enabled,
    false
  )
}

output "aks_identity_type" {

  description = "AKS Managed Identity Type"

  value = try(
    azurerm_kubernetes_cluster.aks.identity[0].type,
    null
  )
}

output "aks_system_assigned_principal_id" {

  description = "AKS System Assigned Principal ID"

  value = (
    try(
      azurerm_kubernetes_cluster.aks.identity[0].type,
      ""
    ) == "SystemAssigned"
  ) ? try(
    azurerm_kubernetes_cluster.aks.identity[0].principal_id,
    null
  ) : null
}

output "aks_user_assigned_identity_ids" {

  description = "AKS User Assigned Identity IDs"

  value = try(
    azurerm_kubernetes_cluster.aks.identity[0].identity_ids,
    []
  )
}

# =====================================
# ENTERPRISE DISPOSABLE ENVIRONMENT
# =====================================

output "aks_identity_principal_ids" {

  description = "AKS Identity Principal IDs"

  value = {

    principal_id = try(
      azurerm_kubernetes_cluster.aks.identity[0].principal_id,
      null
    )

    kubelet_object_id = try(
      azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id,
      null
    )

    kubelet_client_id = try(
      azurerm_kubernetes_cluster.aks.kubelet_identity[0].client_id,
      null
    )
  }
}

# =====================================
# ACR PULL STATUS
# =====================================

output "acr_pull_role_assignment_id" {

  description = "AKS AcrPull Role Assignment ID"

  value = try(
    azurerm_role_assignment.aks_acr_pull[0].id,
    null
  )
}

# =====================================
# ENTERPRISE OIDC STATUS
# =====================================

output "oidc_enabled" {

  description = "OIDC Enabled Status"

  value = var.enable_oidc_issuer
}

# =====================================
# WORKLOAD IDENTITY STATUS
# =====================================

output "workload_identity_status" {

  description = "Workload Identity Status"

  value = {

    enabled = var.enable_workload_identity

    oidc_enabled = var.enable_oidc_issuer

    identity_type = try(
      azurerm_kubernetes_cluster.aks.identity[0].type,
      null
    )
  }
}