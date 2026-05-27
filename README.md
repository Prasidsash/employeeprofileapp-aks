# employeeprofileapp-aks

Enterprise AKS Platform Engineering Repository

---

# Overview

`employeeprofileapp-aks` is an enterprise-grade Azure Kubernetes Service (AKS) platform engineering implementation designed using:

* Azure Kubernetes Service (AKS)
* Terraform Infrastructure as Code
* Helm-based Kubernetes Deployments
* Azure DevOps CI/CD Pipelines
* Azure Container Registry (ACR)
* Azure Monitor
* Log Analytics Workspace
* Managed Prometheus
* Managed Grafana
* Azure Workload Identity
* OIDC Federation
* Azure Key Vault Integration
* Namespace Isolation
* Enterprise Monitoring & Operational Validation

The repository follows a reusable environment-first deployment model aligned with enterprise AKS platform engineering practices.

---

# Repository Structure

```text
employeeprofileapp-aks/
│
├── azure-pipelines/
│   ├── backend-pipeline.yml
│   ├── infra-pipeline.yml
│   ├── app-ci.yml
│   └── app-cd.yml
│
├── helm/
│   └── employeeprofileapp/
│       ├── templates/
│       ├── Chart.yaml
│       ├── values.yaml
│       ├── values-dev.yaml
│       ├── values-qa.yaml
│       ├── values-uat.yaml
│       └── values-prod.yaml
│
├── platform-operations/
│
├── src/
│   └── Employeeprofileapp/
│
├── terraform/
│   ├── bootstrap/
│   │   └── backend/
│   │
│   ├── infra/
│   │   └── dev/
│   │
│   └── modules/
│       ├── acr/
│       ├── aks/
│       ├── aks_backup/
│       ├── cert_manager/
│       ├── employee_governance/
│       ├── employee_ingress/
│       ├── employee_namespace/
│       ├── employee_rbac/
│       ├── employee_secret/
│       ├── federated_identity/
│       ├── ingress_nginx/
│       ├── keyvault/
│       ├── monitoring/
│       ├── network/
│       ├── uami/
│       └── workload_identity/
│
├── Dockerfile
├── employeeprofileapp-aks.sln
├── README.md
└── Terminal-Opener.bat
```

---

# Enterprise Platform Architecture

## Core Design Principles

* Environment-first infrastructure model
* Modular Terraform architecture
* Reusable AKS platform modules
* Independent Infrastructure and Application pipelines
* Secure remote Terraform backend
* Helm-driven Kubernetes deployment model
* Immutable image deployment strategy
* Namespace isolation
* Azure Workload Identity integration
* Enterprise observability implementation
* Runtime deployment validation
* Disposable infrastructure lifecycle

---

# Technology Stack

| Layer                  | Technology                     |
| ---------------------- | ------------------------------ |
| Cloud Platform         | Microsoft Azure                |
| Kubernetes Platform    | Azure Kubernetes Service (AKS) |
| Infrastructure as Code | Terraform                      |
| CI/CD                  | Azure DevOps                   |
| Containerization       | Docker                         |
| Container Registry     | Azure Container Registry (ACR) |
| Kubernetes Packaging   | Helm                           |
| Application Runtime    | .NET 8                         |
| Monitoring             | Azure Monitor                  |
| Logging                | Log Analytics Workspace        |
| Metrics                | Managed Prometheus             |
| Dashboarding           | Managed Grafana                |
| Identity               | Azure Workload Identity        |
| Authentication         | OIDC Federation                |
| Networking             | Azure CNI                      |
| Security               | RBAC + Namespace Isolation     |

---

# Terraform Module Architecture

The repository follows an enterprise reusable modular Terraform architecture.

## Implemented Modules

| Module              | Purpose                                  |
| ------------------- | ---------------------------------------- |
| acr                 | Azure Container Registry deployment      |
| aks                 | AKS cluster deployment and configuration |
| aks_backup          | AKS backup and recovery configuration    |
| cert_manager        | Certificate management integration       |
| employee_governance | Governance controls and resource tagging |
| employee_ingress    | Application ingress integration          |
| employee_namespace  | Kubernetes namespace management          |
| employee_rbac       | Kubernetes RBAC implementation           |
| employee_secret     | Secret management integration            |
| federated_identity  | OIDC federation configuration            |
| ingress_nginx       | NGINX ingress controller deployment      |
| keyvault            | Azure Key Vault integration              |
| monitoring          | Azure Monitor, Prometheus, Grafana       |
| network             | Virtual network and subnet provisioning  |
| uami                | User Assigned Managed Identity           |
| workload_identity   | Azure Workload Identity integration      |

---

# Infrastructure Components Provisioned

The platform provisions:

* Resource Groups
* Virtual Networks
* AKS Cluster
* AKS Node Pools
* Azure Container Registry
* Azure Monitor
* Log Analytics Workspace
* Managed Prometheus
* Managed Grafana
* Azure Key Vault
* User Assigned Managed Identity
* Kubernetes Namespaces
* Kubernetes RBAC
* NGINX Ingress Controller
* Certificate Management
* Monitoring Stack
* OIDC Federation Configuration
* Workload Identity Integration

---

# Azure DevOps SPN and Service Connections

## Azure DevOps Service Principal

```text
azure-devops-sp
```

This SPN is used for:

* Terraform backend authentication
* Azure DevOps pipeline authentication
* AKS authentication
* ACR authentication
* Key Vault access
* Terraform infrastructure deployment

---

## Azure DevOps Service Connections

Validated Service Connections:

* ACR-SC
* AKS SCN
* AzureAKS-SCN
* Docker-SC

All Service Connections were reauthenticated and validated before infrastructure deployment and pipeline execution.

---

# IAM Role Assignments

## Storage Account IAM

Assigned Role:

```text
Storage Blob Data Contributor
```

Assigned To:

```text
azure-devops-sp
```

Purpose:

* Terraform remote backend state read/write
* Terraform state locking

---

## Resource Group IAM

Assigned Role:

```text
Contributor
```

Assigned To:

```text
azure-devops-sp
```

Purpose:

* Terraform infrastructure provisioning
* Azure resource management

---

## Key Vault IAM

Assigned Role:

```text
Key Vault Administrator
```

Assigned To:

```text
azure-devops-sp
```

Purpose:

* Key Vault secret creation
* Secret retrieval
* Secret update
* Secret management

---

## Azure Container Registry IAM

Assigned Roles:

```text
AcrPush
AcrPull
```

Assigned To:

```text
azure-devops-sp
```

Purpose:

* Docker image push from Azure DevOps
* AKS image pull authentication

---

# Terraform Backend Architecture

Terraform remote state is configured using Azure Storage Account backend.

## Backend Components

| Component                  | Purpose                  |
| -------------------------- | ------------------------ |
| Resource Group             | Stores backend resources |
| Storage Account            | Stores Terraform state   |
| Blob Container (`tfstate`) | Stores `.tfstate` files  |

---

# Terraform Cleanup and Reinitialization

## Backend Folder Cleanup

Delete below files/folders from:

```text
terraform\bootstrap\backend
```

Files/Folders:

* `.terraform`
* `.terraform.lock.hcl`
* `terraform.tfstate`
* `terraform.tfstate.backup`

---

## Infrastructure Folder Cleanup

Delete below files/folders from:

```text
terraform\infra\dev
```

Files/Folders:

* `.terraform`
* `.terraform.lock.hcl`
* `terraform.tfstate`
* `terraform.tfstate.backup`

---

## Backend Reinitialization

```powershell
terraform init -reconfigure
```

---

# Enterprise Deployment Workflow

## Deployment Order

```text
1. Backend Pipeline
2. Infrastructure Pipeline
3. Application CI Pipeline
4. Application CD Pipeline
```

---

# Infrastructure Deployment Flow

## Step 1 - Reauthenticate Service Connections

Revalidate and reauthenticate all Azure DevOps Service Connections before pipeline execution.

---

## Step 2 - Configure IAM Permissions

Validate all required IAM role assignments for:

* Storage Account
* Resource Group
* Key Vault
* ACR

---

## Step 3 - Initialize Terraform Backend

```powershell
terraform init -reconfigure
```

---

## Step 4 - Deploy Backend Resources

Run backend Terraform deployment manually.

---

## Step 5 - Deploy Infrastructure

Run infrastructure Terraform deployment manually.

This provisions:

* AKS
* ACR
* Key Vault
* Networking
* Monitoring
* RBAC
* Ingress
* Governance
* Namespaces
* Diagnostics

---

## Step 6 - Connect to AKS Cluster

```powershell
az aks get-credentials --resource-group employeeprofileapp-dev-rg --name employeeprofileapp-dev-aks --overwrite-existing
```

---

## Step 7 - Validate AKS Connectivity

```powershell
kubectl get nodes
kubectl get pods -A
kubectl get namespaces
```

---

# Key Vault Secret Conflict Troubleshooting

Issue:

Azure Key Vault secrets already existed in Azure but corresponding Terraform state entries were missing.

## Resolution

* Cleanup stale Terraform local state
* Reinitialize Terraform backend
* Import existing Azure resources into Terraform state
* Re-run Terraform plan/apply

This resolved Terraform duplicate secret creation conflicts.

---

# Helm Deployment Architecture

The repository uses Helm for Kubernetes application packaging and deployment.

## Helm Features

* Reusable templates
* Environment-specific values files
* Namespace-based deployment
* Runtime image injection
* Resource requests and limits
* Workload identity integration
* Azure Key Vault CSI integration
* Kubernetes service definitions

---

# CI/CD Pipeline Architecture

## Backend Pipeline

Responsible for:

* Terraform backend provisioning
* Remote state setup
* Backend validation

---

## Infrastructure Pipeline

Responsible for:

* AKS provisioning
* Azure resource deployment
* IAM validation
* Monitoring deployment
* Runtime validation

---

## Application CI Pipeline

Responsible for:

* .NET application build
* Docker image creation
* Docker image push to ACR
* Immutable image tagging

---

## Application CD Pipeline

Responsible for:

* AKS authentication
* Helm deployment
* Rollout validation
* Runtime deployment verification

---

# Monitoring & Observability

## Monitoring Stack

Includes:

* Azure Monitor
* Log Analytics Workspace
* Managed Prometheus
* Managed Grafana
* AKS diagnostics
* Container insights

---

## Observability Features

* Pod monitoring
* Node monitoring
* Container log collection
* Metrics visualization
* Deployment diagnostics
* AKS troubleshooting support

---

# AKS Operational Model

## Day-1 Operations

Includes:

* Terraform backend initialization
* AKS cluster provisioning
* Network deployment
* Namespace creation
* RBAC configuration
* Monitoring integration
* ACR integration
* Helm deployment enablement

---

## Day-2 Operations

Includes:

* Helm upgrades
* Image version updates
* Pod troubleshooting
* Rollout validation
* Log analysis
* Infrastructure updates
* Monitoring verification
* Destroy/rebuild lifecycle management

---

# Platform Operations

The repository includes a dedicated `platform-operations` layer for operational support activities including:

* AKS operational validation
* Cluster troubleshooting
* Deployment verification
* Namespace validation
* Rollout validation
* Monitoring verification
* Operational scripts and utilities

---

# Validation Commands

## Terraform Validation

```bash
terraform init
terraform validate
terraform plan
```

---

## AKS Validation

```bash
kubectl get nodes
kubectl get pods -A
kubectl get namespaces
```

---

## Helm Validation

```bash
helm list -A
helm status employeeprofileapp-dev-release -n employeeprofileapp-dev
```

---

## ACR Validation

```bash
az acr repository list --name <acr-name> --output table
```

---

# Security Architecture

Implemented Security Features:

* Azure Workload Identity
* OIDC Federation
* Managed Identity Authentication
* Azure DevOps Service Connections
* Kubernetes RBAC
* Namespace isolation
* Azure RBAC
* Key Vault integration
* Secure Terraform backend
* Immutable image deployment

---

# Common Troubleshooting Areas

* Terraform backend initialization issues
* AKS authentication failures
* ACR image pull failures
* Helm deployment failures
* Kubernetes rollout failures
* Namespace permission issues
* Workload identity validation issues
* Monitoring integration issues
* Azure DevOps permission validation

---

# Enterprise Best Practices Implemented

* Modular Terraform structure
* Environment isolation
* Namespace isolation
* Immutable image deployment
* Runtime deployment validation
* Centralized backend management
* OIDC authentication
* Managed identity integration
* Monitoring-first operational model
* Infrastructure disposability

---

# Deployment Prerequisites

Required Components:

* Azure Subscription
* Azure DevOps Organization
* Azure DevOps Service Connections
* Terraform CLI
* Azure CLI
* Kubectl
* Helm CLI
* Docker Desktop
* .NET 8 SDK

---

# Repository Objectives

This repository demonstrates:

* Enterprise AKS platform engineering
* End-to-end Azure DevOps CI/CD automation
* Terraform modular infrastructure design
* Secure Kubernetes deployment lifecycle
* Enterprise observability implementation
* Real-world AKS operational workflows

---

# Conclusion

`employeeprofileapp-aks` provides a complete enterprise AKS platform engineering implementation combining:

* Terraform Infrastructure as Code
* Azure DevOps CI/CD
* AKS Kubernetes Platform Engineering
* Helm Deployment Automation
* Azure Monitoring Stack
* Workload Identity Integration
* Environment-first Deployment Design
* Enterprise Operational Practices

The repository demonstrates scalable, reusable, cloud-native AKS deployment standards aligned with enterprise platform engineering practices.