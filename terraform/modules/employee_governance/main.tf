# =====================================
# RESOURCE QUOTA
# =====================================

resource "kubernetes_resource_quota_v1" "quota" {

  metadata {

    name = "resource-quota"

    namespace = var.namespace_name

    labels = {

      managed_by = "terraform"

      project = "employeeprofileapp"
    }
  }

  spec {

    hard = var.quota_limits
  }
}

# =====================================
# LIMIT RANGE
# =====================================

resource "kubernetes_limit_range_v1" "limits" {

  metadata {

    name = "limit-range"

    namespace = var.namespace_name

    labels = {

      managed_by = "terraform"

      project = "employeeprofileapp"
    }
  }

  spec {

    limit {

      type = "Container"

      max = var.limit_max

      min = var.limit_min

      default = var.limit_default

      default_request = var.limit_default_request
    }
  }
}