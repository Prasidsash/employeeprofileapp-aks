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

  description = "Enable TLS for ingress"

  type = bool

  default = false
}

variable "tls_secret_name" {

  description = "TLS Secret Name"

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
# OPTIONAL REWRITE TARGET
# =====================================

variable "enable_rewrite_target" {

  description = "Enable ingress rewrite-target annotation"

  type = bool

  default = false
}

# =====================================
# OPTIONAL PROXY BODY SIZE
# =====================================

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

# =====================================
# OPTIONAL SSL PASSTHROUGH
# =====================================

variable "enable_ssl_passthrough" {

  description = "Enable SSL passthrough"

  type = bool

  default = false
}

# =====================================
# OPTIONAL BACKEND PROTOCOL
# =====================================

variable "backend_protocol" {

  description = "Ingress backend protocol"

  type = string

  default = null
}

# =====================================
# OPTIONAL PROXY TIMEOUTS
# =====================================

variable "enable_proxy_timeouts" {

  description = "Enable ingress proxy timeout annotations"

  type = bool

  default = false
}

variable "proxy_connect_timeout" {

  description = "Ingress proxy connect timeout"

  type = string

  default = "60"
}

variable "proxy_read_timeout" {

  description = "Ingress proxy read timeout"

  type = string

  default = "60"
}

variable "proxy_send_timeout" {

  description = "Ingress proxy send timeout"

  type = string

  default = "60"
}

# =====================================
# OPTIONAL SOURCE WHITELIST
# =====================================

variable "whitelist_source_ranges" {

  description = "Optional ingress source whitelist"

  type = list(string)

  default = []
}

# =====================================
# OPTIONAL CUSTOM ANNOTATIONS
# =====================================

variable "additional_annotations" {

  description = "Additional ingress annotations"

  type = map(string)

  default = {}
}