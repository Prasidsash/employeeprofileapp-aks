# =====================================
# FILE: terraform/modules/employee_rbac/outputs.tf
# VERSION: v2-enterprise-disposable-final
# =====================================

output "status" {

  description = "RBAC configuration status"

  value = "configured"
}

output "service_account_name" {

  description = "ServiceAccount name"

  value = kubernetes_service_account_v1.sa.metadata[0].name
}

output "role_name" {

  description = "Role name"

  value = kubernetes_role_v1.role.metadata[0].name
}

output "role_binding_name" {

  description = "RoleBinding name"

  value = kubernetes_role_binding_v1.binding.metadata[0].name
}