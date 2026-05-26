# =====================================
# FILE: terraform/infra/dev/outputs.tf
# VERSION: v5-enterprise-disposable-final
# =====================================

# =====================================
# RESOURCE GROUP
# =====================================

output "resource_group_name" {

  description = "Azure Resource Group Name"

  value = azurerm_resource_group.main.name
}

output "resource_group_id" {

  description = "Azure Resource Group ID"

  value = azurerm_resource_group.main.id
}

# =====================================
# NETWORK
# =====================================

output "subnet_id" {

  description = "AKS subnet ID"

  value = module.network.subnet_id
}

output "vnet_id" {

  description = "Virtual Network ID"

  value = module.network.vnet_id
}

# =====================================
# ACR
# =====================================

output "acr_id" {

  description = "Azure Container Registry ID"

  value = try(
    module.acr[0].acr_id,
    null
  )
}

output "acr_name" {

  description = "Azure Container Registry Name"

  value = try(
    module.acr[0].acr_name,
    null
  )
}

output "acr_login_server" {

  description = "Azure Container Registry Login Server"

  value = try(
    module.acr[0].acr_login_server,
    null
  )
}

# =====================================
# AKS
# =====================================

output "aks_name" {

  description = "AKS cluster name"

  value = module.aks.cluster_name
}

output "aks_cluster_id" {

  description = "AKS Cluster ID"

  value = module.aks.cluster_id
}

output "aks_kubernetes_version" {

  description = "AKS Kubernetes Version"

  value = module.aks.kubernetes_version
}

output "aks_node_resource_group" {

  description = "AKS Node Resource Group"

  value = module.aks.node_resource_group
}

output "aks_fqdn" {

  description = "AKS FQDN"

  value = module.aks.aks_fqdn
}

# =====================================
# AKS MANAGED IDENTITY
# =====================================

output "aks_principal_id" {

  description = "AKS Principal ID"

  value = module.aks.aks_principal_id
}

output "aks_tenant_id" {

  description = "AKS Tenant ID"

  value = module.aks.aks_tenant_id
}

output "tenant_id" {

  description = "Azure Tenant ID"

  value = module.aks.tenant_id
}

# =====================================
# AKS KUBELET IDENTITY
# =====================================

output "aks_kubelet_client_id" {

  description = "AKS Kubelet Client ID"

  value = module.aks.aks_kubelet_client_id
}

output "aks_kubelet_object_id" {

  description = "AKS Kubelet Object ID"

  value = module.aks.aks_kubelet_object_id
}

# =====================================
# OIDC / WORKLOAD IDENTITY
# =====================================

output "aks_oidc_issuer_url" {

  description = "AKS OIDC Issuer URL"

  value = module.aks.aks_oidc_issuer_url
}

output "aks_workload_identity_enabled" {

  description = "AKS Workload Identity Enabled"

  value = module.aks.aks_workload_identity_enabled
}

output "aks_identity_type" {

  description = "AKS Identity Type"

  value = module.aks.aks_identity_type
}

output "aks_user_assigned_identity_ids" {

  description = "AKS User Assigned Identity IDs"

  value = module.aks.aks_user_assigned_identity_ids
}

# =====================================
# ENTERPRISE UAMI OUTPUTS
# =====================================

output "workload_identity_name" {

  description = "User Assigned Managed Identity Name"

  value = try(
    module.aks_workload_identity[0].identity_name,
    null
  )
}

output "workload_identity_client_id" {

  description = "User Assigned Managed Identity Client ID"

  value = try(
    module.aks_workload_identity[0].client_id,
    null
  )
}

output "workload_identity_principal_id" {

  description = "User Assigned Managed Identity Principal ID"

  value = try(
    module.aks_workload_identity[0].principal_id,
    null
  )
}

output "workload_identity_id" {

  description = "User Assigned Managed Identity ID"

  value = try(
    module.aks_workload_identity[0].identity_id,
    null
  )
}

# =====================================
# FEDERATED IDENTITY
# =====================================

output "federated_identity_credential_id" {

  description = "Federated Identity Credential ID"

  value = try(
    module.federated_identity[0].federated_identity_credential_id,
    null
  )
}

# =====================================
# NAMESPACE
# =====================================

output "namespace_name" {

  description = "Kubernetes Namespace"

  value = var.namespace_name
}

# =====================================
# MONITORING
# =====================================

output "log_analytics_workspace_id" {

  description = "Log Analytics Workspace ID"

  value = try(
    module.monitoring[0].log_analytics_workspace_id,
    null
  )
}

output "monitor_workspace_id" {

  description = "Azure Monitor Workspace ID"

  value = try(
    module.monitoring[0].monitor_workspace_id,
    null
  )
}

output "grafana_id" {

  description = "Managed Grafana ID"

  value = try(
    module.monitoring[0].grafana_id,
    null
  )
}

# =====================================
# KEY VAULT
# =====================================

output "key_vault_id" {

  description = "Key Vault ID"

  value = module.keyvault.key_vault_id
}

output "key_vault_name" {

  description = "Key Vault Name"

  value = module.keyvault.key_vault_name
}

output "key_vault_uri" {

  description = "Key Vault URI"

  value = module.keyvault.key_vault_uri
}

output "key_vault_resource_group_name" {

  description = "Key Vault Resource Group Name"

  value = module.keyvault.key_vault_resource_group_name
}

# =====================================
# INGRESS
# =====================================

output "ingress_host" {

  description = "Ingress Host"

  value = var.ingress_host
}

output "ingress_class_name" {

  description = "Ingress Class Name"

  value = var.ingress_class_name
}

# =====================================
# TLS
# =====================================

output "tls_enabled" {

  description = "TLS Enabled Status"

  value = var.enable_tls
}

# =====================================
# CERT MANAGER
# =====================================

output "cert_manager_enabled" {

  description = "cert-manager Enabled"

  value = var.enable_cert_manager
}

output "cluster_issuer_name" {

  description = "ClusterIssuer Name"

  value = var.cluster_issuer_name
}

# =====================================
# RBAC
# =====================================

output "service_account_name" {

  description = "Kubernetes Service Account"

  value = var.service_account_name
}

output "role_name" {

  description = "Kubernetes Role Name"

  value = var.role_name
}

# =====================================
# AKS ACCESS
# =====================================

output "aks_host" {

  description = "AKS API Server Host"

  value = module.aks.host

  sensitive = true
}

output "aks_client_certificate" {

  description = "AKS Client Certificate"

  value = module.aks.client_certificate

  sensitive = true
}

output "aks_client_key" {

  description = "AKS Client Key"

  value = module.aks.client_key

  sensitive = true
}

output "aks_cluster_ca_certificate" {

  description = "AKS Cluster CA Certificate"

  value = module.aks.cluster_ca_certificate

  sensitive = true
}

# =====================================
# ENTERPRISE CD PIPELINE OUTPUTS
# =====================================

output "helm_workload_identity_client_id" {

  description = "Helm Runtime Workload Identity Client ID"

  value = try(
    module.aks_workload_identity[0].client_id,
    null
  )
}

output "helm_keyvault_name" {

  description = "Helm Runtime Key Vault Name"

  value = module.keyvault.key_vault_name
}

output "helm_tenant_id" {

  description = "Helm Runtime Tenant ID"

  value = module.aks.tenant_id
}

# =====================================
# ENTERPRISE DISPOSABLE ENVIRONMENT
# =====================================

output "platform_runtime_configuration" {

  description = "Disposable Environment Runtime Configuration"

  value = {

    environment = var.environment

    namespace = var.namespace_name

    workload_identity_enabled = module.aks.aks_workload_identity_enabled

    oidc_issuer_url = module.aks.aks_oidc_issuer_url

    workload_identity_client_id = try(
      module.aks_workload_identity[0].client_id,
      null
    )

    keyvault_name = module.keyvault.key_vault_name

    ingress_host = var.ingress_host
  }
}