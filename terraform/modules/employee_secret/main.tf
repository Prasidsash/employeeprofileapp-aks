resource "kubernetes_secret" "secret" {

  metadata {

    name = var.secret_name

    namespace = var.namespace_name
  }

  data = var.secret_data

  type = "Opaque"
}