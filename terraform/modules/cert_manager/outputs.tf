# =====================================
# FILE: terraform/modules/cert_manager/outputs.tf
# VERSION: v2-enterprise-disposable-final
# =====================================

output "cert_manager_namespace" {

  description = "cert-manager namespace"

  value = var.namespace
}

output "cluster_issuer_name" {

  description = "ClusterIssuer name"

  value = var.cluster_issuer_name
}

output "status" {

  description = "cert-manager module status"

  value = "configured"
}