variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "system_node_count" {
  type = number
}

variable "system_node_vm_size" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "service_cidr" {
  type = string
}

variable "dns_service_ip" {
  type = string
}

variable "log_analytics_workspace_id" {
  type = string
}

# =====================================
# Managed Prometheus
# =====================================

variable "azure_monitor_workspace_id" {

  description = "Azure Monitor Workspace ID"

  type = string

  default = null
}

# =====================================
# Node Autoscaling
# =====================================

variable "enable_node_autoscaling" {
  type = bool
}

variable "system_node_min_count" {
  type = number
}

variable "system_node_max_count" {
  type = number
}