# =====================================
# KUBERNETES NAMESPACE
# =====================================

resource "kubernetes_namespace_v1" "namespace" {

  metadata {

    name = var.namespace_name

    # =====================================
    # STANDARD PLATFORM LABELS
    # =====================================

    labels = merge(

      {
        managed_by = "terraform"

        project = "employeeprofileapp"
      },

      # =====================================
      # OPTIONAL FUTURE PLATFORM LABELS
      # =====================================

      var.additional_labels,

      # =====================================
      # ENVIRONMENT-SPECIFIC LABELS
      # =====================================

      var.namespace_labels
    )

    # =====================================
    # OPTIONAL ANNOTATIONS
    # =====================================

    annotations = merge(

      # =====================================
      # OPTIONAL FUTURE ANNOTATIONS
      # =====================================

      var.additional_annotations,

      # =====================================
      # ENVIRONMENT ANNOTATIONS
      # =====================================

      var.namespace_annotations
    )
  }
}