# =====================================
# NAMESPACE
# =====================================

variable "namespace_name" {

  description = "Kubernetes namespace name"

  type = string
}

# =====================================
# SERVICE ACCOUNT
# =====================================

variable "service_account_name" {

  description = "Kubernetes ServiceAccount name"

  type = string
}

# =====================================
# ROLE
# =====================================

variable "role_name" {

  description = "Kubernetes Role name"

  type = string
}

# =====================================
# RBAC PERMISSIONS
# =====================================

variable "allowed_resources" {

  description = "Allowed Kubernetes resources"

  type = list(string)
}

variable "allowed_verbs" {

  description = "Allowed Kubernetes verbs"

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

# =====================================
# OPTIONAL ROLE ANNOTATIONS
# =====================================

variable "role_annotations" {

  description = "Optional Kubernetes Role annotations"

  type = map(string)

  default = {}
}

# =====================================
# OPTIONAL ROLE BINDING ANNOTATIONS
# =====================================

variable "role_binding_annotations" {

  description = "Optional Kubernetes RoleBinding annotations"

  type = map(string)

  default = {}
}

# =====================================
# OPTIONAL ADDITIONAL LABELS
# =====================================

variable "additional_labels" {

  description = "Additional platform-level RBAC labels"

  type = map(string)

  default = {}
}

# =====================================
# OPTIONAL ADDITIONAL ANNOTATIONS
# =====================================

variable "additional_annotations" {

  description = "Additional platform-level RBAC annotations"

  type = map(string)

  default = {}
}