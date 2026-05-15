# =====================================
# NAMESPACE
# =====================================

variable "namespace_name" {
  type = string
}

# =====================================
# INGRESS
# =====================================

variable "ingress_name" {
  type = string
}

variable "ingress_host" {
  type = string
}

variable "ingress_path" {
  type = string
}

variable "ingress_path_type" {
  type = string
}

variable "service_name" {
  type = string
}

# =====================================
# OPTIONAL INGRESS CLASS
# =====================================

variable "ingress_class_name" {

  description = "Ingress Controller Class Name"

  type = string

  default = "nginx"
}

# =====================================
# TLS
# =====================================

variable "enable_tls" {

  type = bool

  default = false
}

variable "tls_secret_name" {

  type = string

  default = null
}

# =====================================
# OPTIONAL CERT-MANAGER SUPPORT
# Existing deployments unaffected
# =====================================

variable "cluster_issuer" {

  description = "Optional cert-manager ClusterIssuer"

  type = string

  default = null
}

# =====================================
# OPTIONAL FUTURE INGRESS FEATURES
# =====================================

variable "enable_rewrite_target" {

  description = "Enable ingress rewrite-target annotation"

  type = bool

  default = false
}

variable "enable_proxy_body_size" {

  description = "Enable ingress proxy-body-size annotation"

  type = bool

  default = false
}

variable "proxy_body_size" {

  description = "Ingress proxy body size"

  type = string

  default = "10m"
}