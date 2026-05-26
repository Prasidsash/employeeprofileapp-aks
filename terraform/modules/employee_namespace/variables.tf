# =====================================
# FILE: terraform/modules/employee_namespace/variables.tf
# VERSION: v5-enterprise-disposable-final
# =====================================

# =====================================
# ENVIRONMENT
# =====================================

variable "environment" {

  description = "Environment name"

  type = string
}

# =====================================
# NAMESPACE
# =====================================

variable "namespace_name" {

  description = "Kubernetes namespace name"

  type = string
}

# =====================================
# ENVIRONMENT LABELS
# =====================================

variable "namespace_labels" {

  description = "Environment-specific namespace labels"

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

# =====================================
# OPTIONAL ADDITIONAL LABELS
# =====================================

variable "additional_labels" {

  description = "Additional platform-level namespace labels"

  type = map(string)

  default = {}
}

# =====================================
# OPTIONAL ADDITIONAL ANNOTATIONS
# =====================================

variable "additional_annotations" {

  description = "Additional platform-level namespace annotations"

  type = map(string)

  default = {}
}