# =====================================
# SERVICE ACCOUNT
# =====================================

resource "kubernetes_service_account_v1" "sa" {

  metadata {

    name = var.service_account_name

    namespace = var.namespace_name

    labels = {

      managed_by = "terraform"

      project = "employeeprofileapp"
    }

    annotations = var.service_account_annotations
  }

  # =====================================
  # Optional Future Security Hardening
  # Preserve Existing Behavior
  # =====================================

  automount_service_account_token = true
}

# =====================================
# ROLE
# =====================================

resource "kubernetes_role_v1" "role" {

  metadata {

    name = var.role_name

    namespace = var.namespace_name

    labels = {

      managed_by = "terraform"

      project = "employeeprofileapp"
    }
  }

  rule {

    api_groups = [""]

    resources = var.allowed_resources

    verbs = var.allowed_verbs
  }
}

# =====================================
# ROLE BINDING
# =====================================

resource "kubernetes_role_binding_v1" "binding" {

  metadata {

    name = "${var.role_name}-binding"

    namespace = var.namespace_name

    labels = {

      managed_by = "terraform"

      project = "employeeprofileapp"
    }
  }

  role_ref {

    api_group = "rbac.authorization.k8s.io"

    kind = "Role"

    name = kubernetes_role_v1.role.metadata[0].name
  }

  subject {

    kind = "ServiceAccount"

    name = kubernetes_service_account_v1.sa.metadata[0].name

    namespace = var.namespace_name
  }
}