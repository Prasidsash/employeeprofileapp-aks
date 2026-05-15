# =====================================
# KUBERNETES SECRET
# =====================================

resource "kubernetes_secret" "secret" {

  metadata {

    name = var.secret_name

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
    # OPTIONAL SECRET ANNOTATIONS
    # =====================================

    annotations = merge(

      var.additional_annotations,

      var.secret_annotations
    )
  }

  # =====================================
  # SECRET DATA
  # =====================================

  data = var.secret_data

  # =====================================
  # SECRET TYPE
  # =====================================

  type = var.secret_type

  # =====================================
  # Optional Future Secret Hardening
  # Preserve Existing Behavior
  # =====================================

  immutable = var.secret_immutable
}