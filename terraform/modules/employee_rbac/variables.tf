variable "namespace_name" {
  type = string
}

variable "service_account_name" {
  type = string
}

variable "role_name" {
  type = string
}

variable "allowed_resources" {
  type = list(string)
}

variable "allowed_verbs" {
  type = list(string)
}

# =====================================
# OPTIONAL SERVICE ACCOUNT ANNOTATIONS
# =====================================

variable "service_account_annotations" {

  description = "Optional ServiceAccount annotations"

  type = map(string)

  default = {}
}