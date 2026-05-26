# =====================================
# FILE: terraform/modules/employee_governance/variables.tf
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
# RESOURCE QUOTA
# =====================================

variable "quota_limits" {

  description = "Kubernetes ResourceQuota limits"

  type = map(string)
}

# =====================================
# LIMIT RANGE
# =====================================

variable "limit_max" {

  description = "Maximum container resource limits"

  type = map(string)
}

variable "limit_min" {

  description = "Minimum container resource limits"

  type = map(string)
}

variable "limit_default" {

  description = "Default container resource limits"

  type = map(string)
}

variable "limit_default_request" {

  description = "Default container resource requests"

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

# =====================================
# OPTIONAL ADDITIONAL LABELS
# =====================================

variable "additional_labels" {

  description = "Additional platform-level governance labels"

  type = map(string)

  default = {}
}

# =====================================
# OPTIONAL ADDITIONAL ANNOTATIONS
# =====================================

variable "additional_annotations" {

  description = "Additional platform-level governance annotations"

  type = map(string)

  default = {}
}

# =====================================
# OPTIONAL RESOURCE QUOTA ANNOTATIONS
# =====================================

variable "resource_quota_annotations" {

  description = "Optional ResourceQuota annotations"

  type = map(string)

  default = {}
}

# =====================================
# OPTIONAL LIMIT RANGE ANNOTATIONS
# =====================================

variable "limit_range_annotations" {

  description = "Optional LimitRange annotations"

  type = map(string)

  default = {}
}

# =====================================
# OPTIONAL POD DISRUPTION BUDGET
# =====================================

variable "enable_pod_disruption_budget" {

  description = "Enable PodDisruptionBudget"

  type = bool

  default = false
}

variable "pod_disruption_budget_name" {

  description = "PodDisruptionBudget name"

  type = string

  default = "employeeprofileapp-pdb"
}

variable "pdb_max_unavailable" {

  description = "Maximum unavailable pods during disruption"

  type = string

  default = "1"
}

variable "pdb_match_labels" {

  description = "Match labels for PodDisruptionBudget"

  type = map(string)

  default = {
    app = "employeeprofileapp"
  }
}

variable "pod_disruption_budget_annotations" {

  description = "Optional PodDisruptionBudget annotations"

  type = map(string)

  default = {}
}