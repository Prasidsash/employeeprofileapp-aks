# =====================================
# FILE: terraform/modules/employee_namespace/outputs.tf
# VERSION: v5-enterprise-disposable-final
# =====================================

output "namespace_name" {

  description = "Kubernetes Namespace Name"

  value = kubernetes_namespace_v1.namespace.metadata[0].name
}

output "namespace_uid" {

  description = "Kubernetes Namespace UID"

  value = kubernetes_namespace_v1.namespace.metadata[0].uid
}

output "status" {

  description = "Namespace deployment status"

  value = "configured"
}