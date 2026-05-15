# =====================================
# KUBERNETES NAMESPACE
# =====================================

resource "kubernetes_namespace_v1" "namespace" {

  metadata {

    name = var.namespace_name

    labels = merge(

      {
        managed_by = "terraform"

        project = "employeeprofileapp"
      },

      var.namespace_labels
    )

    annotations = var.namespace_annotations
  }
}