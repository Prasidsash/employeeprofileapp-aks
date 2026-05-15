resource "kubernetes_ingress_v1" "ingress" {

  metadata {

    name = var.ingress_name

    namespace = var.namespace_name

    annotations = merge(

      {
        "nginx.ingress.kubernetes.io/ssl-redirect" = tostring(var.enable_tls)
      },

      # =====================================
      # OPTIONAL CERT-MANAGER SUPPORT
      # Existing deployments unaffected
      # =====================================

      var.enable_tls && var.cluster_issuer != null ? {
        "cert-manager.io/cluster-issuer" = var.cluster_issuer
      } : {},

      # =====================================
      # OPTIONAL FUTURE INGRESS FEATURES
      # =====================================

      var.enable_rewrite_target ? {
        "nginx.ingress.kubernetes.io/rewrite-target" = "/"
      } : {},

      var.enable_proxy_body_size ? {
        "nginx.ingress.kubernetes.io/proxy-body-size" = var.proxy_body_size
      } : {}
    )
  }

  spec {

    # =====================================
    # OPTIONAL INGRESS CLASS
    # =====================================

    ingress_class_name = var.ingress_class_name

    # =====================================
    # TLS
    # =====================================

    dynamic "tls" {

      for_each = var.enable_tls ? [1] : []

      content {

        hosts = [
          var.ingress_host
        ]

        secret_name = var.tls_secret_name
      }
    }

    # =====================================
    # ROUTING RULES
    # =====================================

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