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