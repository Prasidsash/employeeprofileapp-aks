resource "kubernetes_namespace" "namespace" {

  metadata {

    name = var.namespace_name

    labels = var.namespace_labels
  }
}