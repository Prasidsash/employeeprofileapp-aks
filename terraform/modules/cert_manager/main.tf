resource "helm_release" "cert_manager" {

  name = "cert-manager"

  repository = "https://charts.jetstack.io"

  chart = "cert-manager"

  version = var.chart_version

  namespace = var.namespace

  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
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