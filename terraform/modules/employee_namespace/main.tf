# =====================================
# FILE: terraform/modules/employee_namespace/main.tf
# VERSION: v5-enterprise-disposable-final
# =====================================

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

        environment = var.environment

        module = "employee_namespace"
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