variable "namespace_name" {
  type = string
}

variable "secret_name" {
  type = string
}

variable "secret_data" {

  type = map(string)

  sensitive = true
}

# =====================================
# OPTIONAL SECRET ANNOTATIONS
# =====================================

variable "secret_annotations" {

  description = "Optional Kubernetes Secret annotations"

  type = map(string)

  default = {}
}