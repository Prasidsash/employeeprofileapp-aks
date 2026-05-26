# =====================================
# FILE: terraform/modules/employee_rbac/variables.tf
# VERSION: v2-enterprise-disposable-final
# =====================================

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

  description = "Optional RoleBinding annotations"

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

# =====================================
# OPTIONAL HUMAN USER / GROUP RBAC
# =====================================

variable "enable_user_role_binding" {

  description = "Enable Azure AD User/Group RoleBinding"

  type = bool

  default = false
}

variable "aad_user_object_ids" {

  description = "Azure AD User Object IDs"

  type = list(string)

  default = []
}

variable "aad_group_object_ids" {

  description = "Azure AD Group Object IDs"

  type = list(string)

  default = []
}