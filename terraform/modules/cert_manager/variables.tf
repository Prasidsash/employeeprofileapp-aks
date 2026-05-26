# =====================================
# FILE: terraform/modules/cert_manager/variables.tf
# VERSION: v2-enterprise-disposable-final
# =====================================

variable "namespace" {

  description = "cert-manager namespace"

  type = string

  default = "cert-manager"
}

variable "chart_version" {

  description = "cert-manager Helm chart version"

  type = string

  default = "v1.18.2"
}

variable "enable_cluster_issuer" {

  description = "Enable ClusterIssuer creation"

  type = bool

  default = false
}

variable "cluster_issuer_name" {

  description = "ClusterIssuer name"

  type = string

  default = "selfsigned-cluster-issuer"
}