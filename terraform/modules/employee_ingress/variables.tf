variable "namespace_name" {
  type = string
}

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