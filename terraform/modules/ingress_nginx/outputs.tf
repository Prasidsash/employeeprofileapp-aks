# =====================================
# FILE: terraform/modules/ingress_nginx/outputs.tf
# VERSION: v2-enterprise-disposable-final
# =====================================

output "ingress_namespace" {

  description = "Ingress NGINX namespace"

  value = helm_release.ingress_nginx.namespace
}

output "ingress_release_name" {

  description = "Ingress NGINX Helm release name"

  value = helm_release.ingress_nginx.name
}

output "ingress_status" {

  description = "Ingress NGINX deployment status"

  value = "configured"
}