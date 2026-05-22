variable "namespace" {

  description = "cert-manager namespace"

  type = string

  default = "cert-manager"
}

variable "chart_version" {

  description = "cert-manager chart version"

  type = string

  default = "v1.18.2"
}

variable "enable_cluster_issuer" {

  description = "Enable ClusterIssuer"

  type = bool

  default = false
}

variable "cluster_issuer_name" {

  description = "ClusterIssuer name"

  type = string

  default = "selfsigned-cluster-issuer"
}