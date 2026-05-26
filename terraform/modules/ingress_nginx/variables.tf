# =====================================
# FILE: terraform/modules/ingress_nginx/variables.tf
# VERSION: v2-enterprise-disposable-final
# =====================================

variable "namespace" {

  description = "Kubernetes namespace for ingress-nginx"

  type = string
}

variable "chart_version" {

  description = "Helm chart version"

  type = string
}

variable "service_type" {

  description = "Ingress controller service type"

  type = string
}

variable "replica_count" {

  description = "Number of ingress controller replicas"

  type = number
}

variable "additional_values" {

  description = "Optional additional Helm values"

  type = map(string)

  default = {}
}