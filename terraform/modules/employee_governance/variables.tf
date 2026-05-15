variable "namespace_name" {
  type = string
}

variable "quota_limits" {
  type = map(string)
}

variable "limit_max" {
  type = map(string)
}

variable "limit_min" {
  type = map(string)
}

variable "limit_default" {
  type = map(string)
}

variable "limit_default_request" {
  type = map(string)
}

# =====================================
# OPTIONAL FUTURE METADATA SUPPORT
# =====================================

variable "labels" {

  description = "Optional governance labels"

  type = map(string)

  default = {}
}

variable "annotations" {

  description = "Optional governance annotations"

  type = map(string)

  default = {}
}