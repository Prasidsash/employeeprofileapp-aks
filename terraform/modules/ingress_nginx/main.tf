# =====================================
# FILE: terraform/modules/ingress_nginx/main.tf
# VERSION: v2-enterprise-disposable-final
# =====================================

resource "helm_release" "ingress_nginx" {

  name = "ingress-nginx"

  repository = "https://kubernetes.github.io/ingress-nginx"

  chart = "ingress-nginx"

  version = var.chart_version

  namespace = var.namespace

  create_namespace = true

  wait = true

  timeout = 900

  atomic = false

  cleanup_on_fail = false

  # =====================================
  # CONTROLLER CONFIGURATION
  # =====================================

  set {
    name  = "controller.service.type"
    value = var.service_type
  }

  set {
    name  = "controller.replicaCount"
    value = var.replica_count
  }

  set {
    name  = "controller.publishService.enabled"
    value = "true"
  }

  # =====================================
  # OPTIONAL STABILITY SETTINGS
  # =====================================

  set {
    name  = "controller.resources.requests.cpu"
    value = "100m"
  }

  set {
    name  = "controller.resources.requests.memory"
    value = "128Mi"
  }

  set {
    name  = "controller.resources.limits.cpu"
    value = "500m"
  }

  set {
    name  = "controller.resources.limits.memory"
    value = "512Mi"
  }
}