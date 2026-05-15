resource "kubernetes_ingress_v1" "ingress" {

  metadata {

    name = var.ingress_name

    namespace = var.namespace_name

    annotations = merge(

      # =====================================
      # CORE INGRESS SETTINGS
      # =====================================

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
      # OPTIONAL REWRITE TARGET
      # =====================================

      var.enable_rewrite_target ? {
        "nginx.ingress.kubernetes.io/rewrite-target" = "/"
      } : {},

      # =====================================
      # OPTIONAL PROXY BODY SIZE
      # =====================================

      var.enable_proxy_body_size ? {
        "nginx.ingress.kubernetes.io/proxy-body-size" = var.proxy_body_size
      } : {},

      # =====================================
      # OPTIONAL SSL PASSTHROUGH
      # =====================================

      var.enable_ssl_passthrough ? {
        "nginx.ingress.kubernetes.io/ssl-passthrough" = "true"
      } : {},

      # =====================================
      # OPTIONAL BACKEND PROTOCOL
      # =====================================

      var.backend_protocol != null ? {
        "nginx.ingress.kubernetes.io/backend-protocol" = var.backend_protocol
      } : {},

      # =====================================
      # OPTIONAL PROXY TIMEOUTS
      # =====================================

      var.enable_proxy_timeouts ? {
        "nginx.ingress.kubernetes.io/proxy-connect-timeout" = var.proxy_connect_timeout
        "nginx.ingress.kubernetes.io/proxy-read-timeout"    = var.proxy_read_timeout
        "nginx.ingress.kubernetes.io/proxy-send-timeout"    = var.proxy_send_timeout
      } : {},

      # =====================================
      # OPTIONAL SOURCE WHITELIST
      # =====================================

      length(var.whitelist_source_ranges) > 0 ? {
        "nginx.ingress.kubernetes.io/whitelist-source-range" = join(",", var.whitelist_source_ranges)
      } : {},

      # =====================================
      # OPTIONAL CUSTOM ANNOTATIONS
      # =====================================

      var.additional_annotations
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