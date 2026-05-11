resource "kubernetes_service_account" "sa" {

  metadata {

    name = var.service_account_name

    namespace = var.namespace_name
  }
}

resource "kubernetes_role" "role" {

  metadata {

    name = var.role_name

    namespace = var.namespace_name
  }

  rule {

    api_groups = [""]

    resources = var.allowed_resources

    verbs = var.allowed_verbs
  }
}

resource "kubernetes_role_binding" "binding" {

  metadata {

    name = "${var.role_name}-binding"

    namespace = var.namespace_name
  }

  role_ref {

    api_group = "rbac.authorization.k8s.io"

    kind = "Role"

    name = kubernetes_role.role.metadata[0].name
  }

  subject {

    kind = "ServiceAccount"

    name = kubernetes_service_account.sa.metadata[0].name

    namespace = var.namespace_name
  }
}