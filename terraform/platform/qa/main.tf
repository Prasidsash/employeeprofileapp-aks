module "employee_namespace" {

  source = "../../modules/employee_namespace"

  namespace_name = var.namespace_name

  namespace_labels = var.namespace_labels
}

module "employee_rbac" {

  source = "../../modules/employee_rbac"

  namespace_name = var.namespace_name

  service_account_name = var.service_account_name

  role_name = var.role_name

  allowed_resources = var.allowed_resources

  allowed_verbs = var.allowed_verbs
}

module "employee_secret" {

  source = "../../modules/employee_secret"

  namespace_name = var.namespace_name

  secret_name = var.secret_name

  secret_data = var.secret_data
}

module "employee_ingress" {

  source = "../../modules/employee_ingress"

  namespace_name = var.namespace_name

  ingress_name = var.ingress_name

  ingress_host = var.ingress_host

  ingress_path = var.ingress_path

  ingress_path_type = var.ingress_path_type

  service_name = var.service_name
}

module "employee_governance" {

  source = "../../modules/employee_governance"

  namespace_name = var.namespace_name

  quota_limits = var.quota_limits

  limit_max = var.limit_max

  limit_min = var.limit_min

  limit_default = var.limit_default

  limit_default_request = var.limit_default_request
}