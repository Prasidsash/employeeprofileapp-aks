# =====================================
# KUBERNETES SECRET
# =====================================

resource "kubernetes_secret" "secret" {

  metadata {

    name = var.secret_name

    namespace = var.namespace_name

    labels = {

      managed_by = "terraform"

      project = "employeeprofileapp"
    }

    annotations = var.secret_annotations
  }

  # =====================================
  # SECRET DATA
  # =====================================

  data = var.secret_data

  type = "Opaque"

  # =====================================
  # Optional Future Secret Hardening
  # Preserve Existing Behavior
  # =====================================

  immutable = false
}