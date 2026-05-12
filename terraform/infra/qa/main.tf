module "network" {
  source = "../../modules/network"

  resource_group_name = var.resource_group_name
  location = var.location

  vnet_name = var.vnet_name
  vnet_address_space = var.vnet_address_space

  aks_subnet_name = var.aks_subnet_name
  aks_subnet_prefixes = var.aks_subnet_prefixes
}

module "monitoring" {
  source = "../../modules/monitoring"

  resource_group_name = var.resource_group_name
  location = var.location

  log_analytics_workspace_name = var.log_analytics_workspace_name
  log_analytics_sku = var.log_analytics_sku
  log_retention_in_days = var.log_retention_in_days
}

module "aks" {
  source = "../../modules/aks"

  resource_group_name = var.resource_group_name
  location = var.location

  cluster_name = var.cluster_name
  kubernetes_version = var.kubernetes_version

  system_node_count = var.system_node_count
  system_node_vm_size = var.system_node_vm_size

  subnet_id = module.network.subnet_id

  log_analytics_workspace_id = module.monitoring.workspace_id

  service_cidr = var.service_cidr
  dns_service_ip = var.dns_service_ip
}