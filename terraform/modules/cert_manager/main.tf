# =====================================
# FILE: terraform/modules/cert_manager/main.tf
# VERSION: v2-enterprise-disposable-final
# =====================================

resource "helm_release" "cert_manager" {

  name = "cert-manager"

  repository = "https://charts.jetstack.io"

  chart = "cert-manager"

  version = var.chart_version

  namespace = var.namespace

  create_namespace = true

  # =====================================
  # HELM STABILIZATION
  # =====================================

  wait = true

  wait_for_jobs = true

  timeout = 1200

  atomic = false

  cleanup_on_fail = false

  dependency_update = true

  # =====================================
  # CERT MANAGER CRDS
  # =====================================

  set {
    name  = "installCRDs"
    value = "true"
  }

  # =====================================
  # OPTIONAL HARDENING FLAGS
  # =====================================

  set {
    name  = "global.leaderElection.namespace"
    value = var.namespace
  }

  set {
    name  = "prometheus.enabled"
    value = "false"
  }
}

# =====================================
# OPTIONAL CLUSTER ISSUER
# =====================================

resource "kubectl_manifest" "cluster_issuer" {

  count = var.enable_cluster_issuer ? 1 : 0

  yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: ${var.cluster_issuer_name}
spec:
  selfSigned: {}
YAML

  depends_on = [
    helm_release.cert_manager
  ]
}