resource "azurerm_resource_group" "main" {

  name = var.resource_group_name

  location = var.location

  tags = {

    environment = var.environment

    project = "employeeprofileapp"

    managed_by = "terraform"
  }
}

module "network" {

  source = "../../modules/network"

  environment = var.environment

  resource_group_name = azurerm_resource_group.main.name

  location = var.location

  vnet_name          = var.vnet_name
  vnet_address_space = var.vnet_address_space

  aks_subnet_name     = var.aks_subnet_name
  aks_subnet_prefixes = var.aks_subnet_prefixes
}

module "monitoring" {

  source = "../../modules/monitoring"

  environment = var.environment

  resource_group_name = azurerm_resource_group.main.name

  location = var.location

  log_analytics_workspace_name = var.log_analytics_workspace_name

  log_analytics_sku = var.log_analytics_sku

  log_retention_in_days = var.log_retention_in_days
}

module "aks" {

  source = "../../modules/aks"

  environment = var.environment

  resource_group_name = azurerm_resource_group.main.name

  location = var.location

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version

  system_node_count   = var.system_node_count
  system_node_vm_size = var.system_node_vm_size

  subnet_id = module.network.subnet_id

  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id

  service_cidr = var.service_cidr

  dns_service_ip = var.dns_service_ip
}

module "namespace" {

  source = "../../modules/employee_namespace"

  count = var.enable_namespace ? 1 : 0

  namespace_name = var.namespace_name

  namespace_labels = var.namespace_labels
}

module "governance" {

  source = "../../modules/employee_governance"

  count = var.enable_governance ? 1 : 0

  namespace_name = var.namespace_name

  quota_limits = var.quota_limits

  limit_max = var.limit_max

  limit_min = var.limit_min

  limit_default = var.limit_default

  limit_default_request = var.limit_default_request
}

module "rbac" {

  source = "../../modules/employee_rbac"

  count = var.enable_rbac ? 1 : 0

  namespace_name = var.namespace_name

  service_account_name = var.service_account_name

  role_name = var.role_name

  allowed_resources = var.allowed_resources

  allowed_verbs = var.allowed_verbs
}

module "secret" {

  source = "../../modules/employee_secret"

  count = var.enable_secret ? 1 : 0

  namespace_name = var.namespace_name

  secret_name = var.secret_name

  secret_data = var.secret_data
}

module "ingress" {

  source = "../../modules/employee_ingress"

  count = var.enable_ingress ? 1 : 0

  namespace_name = var.namespace_name

  ingress_name = var.ingress_name

  ingress_host = var.ingress_host

  ingress_path = var.ingress_path

  ingress_path_type = var.ingress_path_type

  service_name = var.service_name
}