# =====================================
# NAMESPACE
# =====================================

variable "namespace_name" {

  description = "Kubernetes namespace name"

  type = string
}

# =====================================
# SECRET
# =====================================

variable "secret_name" {

  description = "Kubernetes Secret name"

  type = string
}

variable "secret_data" {

  description = "Sensitive secret data"

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

# =====================================
# OPTIONAL ADDITIONAL LABELS
# =====================================

variable "additional_labels" {

  description = "Additional platform-level Secret labels"

  type = map(string)

  default = {}
}

# =====================================
# OPTIONAL ADDITIONAL ANNOTATIONS
# =====================================

variable "additional_annotations" {

  description = "Additional platform-level Secret annotations"

  type = map(string)

  default = {}
}

# =====================================
# OPTIONAL SECRET TYPE
# =====================================

variable "secret_type" {

  description = "Kubernetes Secret type"

  type = string

  default = "Opaque"
}

# =====================================
# OPTIONAL SECRET IMMUTABILITY
# =====================================

variable "secret_immutable" {

  description = "Enable immutable secret"

  type = bool

  default = false
}