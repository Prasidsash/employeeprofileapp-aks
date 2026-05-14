resource "kubernetes_ingress_v1" "ingress" {

  metadata {

    name = var.ingress_name

    namespace = var.namespace_name

    annotations = {

      "nginx.ingress.kubernetes.io/ssl-redirect" = tostring(var.enable_tls)
    }
  }

  spec {

    dynamic "tls" {

      for_each = var.enable_tls ? [1] : []

      content {

        hosts = [
          var.ingress_host
        ]

        secret_name = var.tls_secret_name
      }
    }

    rule {

      host = var.ingress_host

      http {

        path {

          path = var.ingress_path

          path_type = var.ingress_path_type

          backend {

            service {

              name = var.service_name

              port {

                number = 80
              }
            }
          }
        }
      }
    }
  }
}