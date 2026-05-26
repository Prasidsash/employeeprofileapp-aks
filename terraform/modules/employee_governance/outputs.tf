# =====================================
# FILE: terraform/modules/employee_governance/outputs.tf
# VERSION: v2-enterprise-disposable-final
# =====================================

output "status" {

  description = "Governance module status"

  value = "configured"
}

output "module_name" {

  description = "Module name"

  value = "employee_governance"
}