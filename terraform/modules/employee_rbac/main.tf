# =====================================
# SERVICE ACCOUNT
# =====================================

resource "kubernetes_service_account_v1" "sa" {

  metadata {

    name = var.service_account_name

    namespace = var.namespace_name

    # =====================================
    # STANDARD PLATFORM LABELS
    # =====================================

    labels = merge(

      {
        managed_by = "terraform"

        project = "employeeprofileapp"
      },

      # =====================================
      # OPTIONAL ADDITIONAL LABELS
      # =====================================

      var.additional_labels
    )

    # =====================================
    # OPTIONAL SERVICE ACCOUNT ANNOTATIONS
    # =====================================

    annotations = merge(

      var.additional_annotations,

      var.service_account_annotations
    )
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

    # =====================================
    # STANDARD PLATFORM LABELS
    # =====================================

    labels = merge(

      {
        managed_by = "terraform"

        project = "employeeprofileapp"
      },

      # =====================================
      # OPTIONAL ADDITIONAL LABELS
      # =====================================

      var.additional_labels
    )

    # =====================================
    # OPTIONAL ROLE ANNOTATIONS
    # =====================================

    annotations = merge(

      var.additional_annotations,

      var.role_annotations
    )
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

    # =====================================
    # STANDARD PLATFORM LABELS
    # =====================================

    labels = merge(

      {
        managed_by = "terraform"

        project = "employeeprofileapp"
      },

      # =====================================
      # OPTIONAL ADDITIONAL LABELS
      # =====================================

      var.additional_labels
    )

    # =====================================
    # OPTIONAL ROLE BINDING ANNOTATIONS
    # =====================================

    annotations = merge(

      var.additional_annotations,

      var.role_binding_annotations
    )
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

# =====================================
# OPTIONAL HUMAN USER / GROUP ROLE BINDING
# =====================================

resource "kubernetes_role_binding_v1" "aad_binding" {

  count = var.enable_user_role_binding ? 1 : 0

  metadata {

    name = "${var.role_name}-aad-binding"

    namespace = var.namespace_name

    # =====================================
    # STANDARD PLATFORM LABELS
    # =====================================

    labels = merge(

      {
        managed_by = "terraform"

        project = "employeeprofileapp"
      },

      var.additional_labels
    )

    # =====================================
    # OPTIONAL ROLE BINDING ANNOTATIONS
    # =====================================

    annotations = merge(

      var.additional_annotations,

      var.role_binding_annotations
    )
  }

  role_ref {

    api_group = "rbac.authorization.k8s.io"

    kind = "Role"

    name = kubernetes_role_v1.role.metadata[0].name
  }

  # =====================================
  # AAD USERS
  # =====================================

  dynamic "subject" {

    for_each = var.aad_user_object_ids

    content {

      kind = "User"

      name = subject.value

      api_group = "rbac.authorization.k8s.io"
    }
  }

  # =====================================
  # AAD GROUPS
  # =====================================

  dynamic "subject" {

    for_each = var.aad_group_object_ids

    content {

      kind = "Group"

      name = subject.value

      api_group = "rbac.authorization.k8s.io"
    }
  }
}