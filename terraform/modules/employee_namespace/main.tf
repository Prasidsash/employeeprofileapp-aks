resource "kubernetes_namespace_v1" "namespace" {

  metadata {

    name = var.namespace_name

    labels = var.namespace_labels
  }
}