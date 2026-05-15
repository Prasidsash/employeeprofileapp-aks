variable "namespace_name" {
  type = string
}

variable "namespace_labels" {
  type = map(string)
}

# =====================================
# OPTIONAL NAMESPACE ANNOTATIONS
# =====================================

variable "namespace_annotations" {

  description = "Optional namespace annotations"

  type = map(string)

  default = {}
}