# EmployeeProfileApp-AKS

Enterprise AKS Platform Engineering Repository using Azure Kubernetes Service (AKS), Terraform Infrastructure as Code, Azure DevOps CI/CD, Helm-based Kubernetes Deployments, Azure SQL Database, Workload Identity, Monitoring Stack, and Enterprise Kubernetes Operational Practices.

---

# Overview

`employeeprofileapp-aks` is a real-world enterprise-grade AKS platform engineering implementation designed to simulate production-style cloud-native infrastructure deployment and Kubernetes operational workflows in Microsoft Azure.

The repository combines:

* AKS platform engineering
* Terraform modular infrastructure automation
* Azure DevOps CI/CD pipelines
* Docker container lifecycle management
* Helm-based Kubernetes deployments
* Azure-native monitoring integrations
* Workload Identity & OIDC federation
* Namespace isolation
* Enterprise RBAC implementation
* Azure SQL Database integration
* Operational troubleshooting workflows
* Environment-first infrastructure architecture

The implementation closely resembles enterprise cloud-native deployment standards used in modern organizations.

---

# Enterprise Platform Architecture

```text
Developer
   │
   ▼
Azure DevOps Repositories
   │
   ├── Backend Pipeline
   ├── Infrastructure Pipeline
   ├── Application CI Pipeline
   └── Application CD Pipeline
   │
   ▼
Azure Container Registry (ACR)
   │
   ▼
Azure Kubernetes Service (AKS)
   │
   ├── NGINX Ingress Controller
   ├── Kubernetes Namespaces
   ├── RBAC
   ├── Workload Identity
   ├── Azure Key Vault Integration
   ├── Monitoring Stack
   ├── Helm Releases
   ├── Application Pods
   └── Operational Validation
   │
   ▼
Azure SQL Database
```

---

# Core Design Principles

The repository follows enterprise AKS platform engineering principles:

* Environment-first infrastructure design
* Modular Terraform architecture
* Reusable infrastructure modules
* Independent infrastructure and application pipelines
* Immutable container deployment strategy
* Secure remote Terraform backend
* Namespace isolation
* Azure-native authentication model
* Monitoring-first operational approach
* Runtime validation workflows
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
| Database               | Azure SQL Database             |

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
│   └── EmployeeProfileApp/
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
│       ├── sql/
│       ├── uami/
│       └── workload_identity/
│
├── Dockerfile
├── employeeprofileapp-aks.sln
├── README.md
└── Terminal-Opener.bat
```

---

# Folder-by-Folder Explanation

---

# azure-pipelines/

Contains Azure DevOps YAML pipelines used for infrastructure provisioning, CI/CD automation, and Kubernetes deployments.

---

## backend-pipeline.yml

Purpose:

* Deploy Terraform backend infrastructure.

Responsibilities:

* Create remote backend resources
* Configure Terraform state storage
* Validate backend readiness

Why Needed:

* Enterprise Terraform deployments require centralized remote state management.

---

## infra-pipeline.yml

Purpose:

* Deploy Azure infrastructure resources.

Responsibilities:

* Terraform initialization
* Infrastructure validation
* AKS deployment
* Monitoring deployment
* Networking deployment
* SQL infrastructure deployment

Why Needed:

* Automates complete infrastructure provisioning.

---

## app-ci.yml

Purpose:

* Build and package the application.

Responsibilities:

* Restore .NET dependencies
* Build application
* Execute tests
* Build Docker image
* Push image to ACR

Why Needed:

* Implements enterprise Continuous Integration workflow.

---

## app-cd.yml

Purpose:

* Deploy application into AKS.

Responsibilities:

* Authenticate with AKS
* Pull Helm chart
* Deploy using Helm
* Validate rollout status

Why Needed:

* Automates Kubernetes application deployment lifecycle.

---

# helm/

Contains Helm chart used for Kubernetes deployments.

Helm acts as a Kubernetes package manager enabling reusable and standardized deployments.

---

## Chart.yaml

Purpose:

* Helm chart metadata definition.

Contains:

* Chart name
* Chart version
* Application version

---

## values.yaml

Purpose:

* Default Helm deployment configuration.

Contains:

* Replica count
* Image repository
* Resource limits
* Service configuration

---

## values-dev.yaml / values-qa.yaml / values-uat.yaml / values-prod.yaml

Purpose:

* Environment-specific configuration values.

Used For:

* Different replica counts
* Different ingress hosts
* Environment-specific image tags
* Resource customization

Why Needed:

* Supports reusable multi-environment deployments.

---

## templates/

Contains reusable Kubernetes YAML templates.

---

### deployment.yaml

Creates:

* Kubernetes Deployments

Responsibilities:

* Pod creation
* Replica management
* Container runtime configuration

---

### service.yaml

Creates:

* Kubernetes Services

Responsibilities:

* Internal networking
* Pod exposure inside cluster

---

### ingress.yaml

Creates:

* Kubernetes Ingress resources

Responsibilities:

* External traffic routing
* HTTP/HTTPS exposure

Integrated With:

* NGINX Ingress Controller

---

### configmap.yaml

Purpose:

* Store non-sensitive configuration.

Examples:

* Environment variables
* Runtime application settings

---

### secret.yaml

Purpose:

* Store sensitive configuration securely.

Examples:

* Database credentials
* Connection strings

---

### serviceaccount.yaml

Purpose:

* Create Kubernetes Service Account.

Used For:

* Workload Identity integration
* Azure resource authentication

---

### hpa.yaml

Purpose:

* Configure Horizontal Pod Autoscaler.

Benefits:

* Automatic scaling
* Resource optimization

---

### _helpers.tpl

Purpose:

* Reusable Helm helper functions.

Used For:

* Naming standards
* Labels
* Template reuse

---

# platform-operations/

Contains operational support scripts and runtime validation activities.

Responsibilities:

* AKS operational verification
* Rollout validation
* Monitoring verification
* Troubleshooting support
* Day-2 operational workflows

Why Needed:

* Enterprise AKS environments require operational support tooling.

---

# src/

Contains actual ASP.NET Core application source code.

---

## Controllers/

Purpose:

* Handle incoming HTTP/API requests.

Responsibilities:

* API endpoint handling
* Request processing

---

## Models/

Purpose:

* Define application data models.

Examples:

* Employee entity
* Database models

---

## Views/

Purpose:

* UI rendering layer.

Used In:

* MVC application pages

---

## Services/

Purpose:

* Business logic implementation.

Responsibilities:

* Data processing
* Service operations

---

## Data/

Purpose:

* Database connectivity layer.

Responsibilities:

* SQL interaction
* Data access logic
* Entity Framework operations

---

## appsettings.json

Purpose:

* Application runtime configuration.

Contains:

* Logging settings
* Connection strings
* Environment configuration

---

## Program.cs

Purpose:

* Main application startup file.

Responsibilities:

* Configure services
* Configure middleware
* Start application runtime

---

# terraform/

Contains complete Infrastructure as Code implementation.

Terraform provisions all Azure infrastructure resources.

---

# bootstrap/

Used for Terraform backend initialization.

Purpose:

* Create remote Terraform backend resources.

Resources:

* Storage Account
* Blob Container
* Resource Group

Benefits:

* Centralized Terraform state
* Team collaboration
* State locking support

---

# infra/

Contains actual infrastructure deployment configuration.

Environment-first structure is followed.

Example:

```text
infra/dev
infra/qa
infra/uat
infra/prod
```

Benefits:

* Environment isolation
* Independent deployments
* Enterprise scalability

---

# modules/

Contains reusable enterprise Terraform modules.

Each module provisions one infrastructure capability.

---

## acr/

Purpose:

* Deploy Azure Container Registry.

Responsibilities:

* Store Docker images
* Integrate with AKS image pulls

---

## aks/

Purpose:

* Deploy AKS cluster.

Features:

* Node pools
* OIDC issuer
* Workload Identity
* RBAC
* Azure CNI networking

---

## aks_backup/

Purpose:

* Configure AKS backup and recovery capabilities.

Why Needed:

* Enterprise disaster recovery support.

---

## cert_manager/

Purpose:

* Certificate management integration.

Responsibilities:

* TLS certificate automation
* HTTPS support

---

## employee_governance/

Purpose:

* Apply enterprise governance standards.

Responsibilities:

* Resource tagging
* Naming conventions
* Compliance-ready structure

---

## employee_ingress/

Purpose:

* Application ingress configuration.

Responsibilities:

* Application routing
* External traffic integration

---

## employee_namespace/

Purpose:

* Create Kubernetes namespaces.

Examples:

* ingress-nginx
* monitoring
* employeeprofileapp

Benefits:

* Isolation
* Governance
* Multi-team separation

---

## employee_rbac/

Purpose:

* Implement Kubernetes RBAC.

Responsibilities:

* Roles
* RoleBindings
* Namespace permissions

Benefits:

* Least privilege access
* Enterprise security model

---

## employee_secret/

Purpose:

* Secret management integration.

Responsibilities:

* Kubernetes secrets
* Secret synchronization

---

## federated_identity/

Purpose:

* Configure OIDC federation.

Benefits:

* Secure Azure authentication
* Passwordless authentication model

---

## ingress_nginx/

Purpose:

* Deploy NGINX Ingress Controller.

Responsibilities:

* HTTP/HTTPS routing
* External ingress management

Traffic Flow:

```text
Internet
   ↓
NGINX Ingress Controller
   ↓
Kubernetes Service
   ↓
Application Pods
```

---

## keyvault/

Purpose:

* Integrate Azure Key Vault.

Used For:

* Secure secret storage
* Centralized secret management

Examples:

* Database credentials
* Connection strings

---

## monitoring/

Purpose:

* Deploy enterprise monitoring stack.

Resources:

* Azure Monitor
* Log Analytics Workspace
* Managed Prometheus
* Managed Grafana

Capabilities:

* Metrics collection
* Pod monitoring
* Dashboarding
* AKS diagnostics

---

## network/

Purpose:

* Create AKS networking layer.

Resources:

* Virtual Network
* Subnets
* NSGs

Responsibilities:

* AKS network isolation
* Internal communication

---

## sql/

Purpose:

* Deploy Azure SQL infrastructure.

Resources:

* SQL Server
* SQL Database
* Firewall Rules

Problem Solved:

* Persistent backend application storage

Variables:

```hcl
db_username
db_password
```

---

## uami/

Purpose:

* Deploy User Assigned Managed Identity.

Benefits:

* Azure resource authentication
* Managed identity integration

---

## workload_identity/

Purpose:

* Configure AKS Workload Identity.

Benefits:

* Passwordless Azure access
* Secure pod identity
* No hardcoded secrets

Authentication Flow:

```text
AKS Pod
   ↓
Kubernetes Service Account
   ↓
Workload Identity
   ↓
Managed Identity
   ↓
Azure Resource
```

---

# Dockerfile

Purpose:

* Containerize the .NET application.

Responsibilities:

* Multi-stage build
* Runtime optimization
* Docker image packaging

Benefits:

* Portable deployment
* Kubernetes compatibility

---

# employeeprofileapp-aks.sln

Purpose:

* Visual Studio solution file.

Used For:

* Manage .NET project structure
* Centralized solution management

---

# Terminal-Opener.bat

Purpose:

* Quick terminal access utility.

Used For:

* Faster local development workflows

---

# Terraform Backend Architecture

Terraform remote state uses Azure Storage Account backend.

Backend Components:

| Component       | Purpose                 |
| --------------- | ----------------------- |
| Resource Group  | Store backend resources |
| Storage Account | Store Terraform state   |
| Blob Container  | Store `.tfstate` files  |

Benefits:

* Centralized state management
* Terraform state locking
* Team collaboration

---

# Azure DevOps Service Principal

## azure-devops-sp

Used For:

* Terraform authentication
* AKS authentication
* ACR authentication
* Key Vault access
* Infrastructure deployment

---

# Service Connections

Validated Connections:

* ACR-SC
* AKS SCN
* AzureAKS-SCN
* Docker-SC

Purpose:

* Secure Azure DevOps integration with Azure resources.

---

# IAM Role Assignments

Implemented Roles:

| Role                          | Purpose                   |
| ----------------------------- | ------------------------- |
| Contributor                   | Infrastructure deployment |
| Storage Blob Data Contributor | Terraform backend access  |
| Key Vault Administrator       | Secret management         |
| AcrPush                       | Docker image push         |
| AcrPull                       | AKS image pull            |

---

# Enterprise Deployment Workflow

Deployment Order:

```text
1. Backend Pipeline
2. Infrastructure Pipeline
3. Application CI Pipeline
4. Application CD Pipeline
```

---

# Infrastructure Deployment Flow

## Step 1 — Reauthenticate Service Connections

Ensures:

* Valid Azure authentication
* Pipeline authorization

---

## Step 2 — Configure IAM Permissions

Validates:

* Storage permissions
* Resource Group permissions
* Key Vault permissions
* ACR permissions

---

## Step 3 — Initialize Terraform Backend

```powershell
terraform init -reconfigure
```

Purpose:

* Initialize remote backend state.

---

## Step 4 — Deploy Backend Resources

Deploy:

* Storage Account
* Blob Container
* Backend Resource Group

---

## Step 5 — Deploy Infrastructure

Deploys:

* AKS
* Networking
* Monitoring
* RBAC
* Ingress
* Key Vault
* SQL Database

---

## Step 6 — Connect to AKS Cluster

```powershell
az aks get-credentials --resource-group employeeprofileapp-dev-rg --name employeeprofileapp-dev-aks --overwrite-existing
```

---

## Step 7 — Validate AKS Connectivity

```bash
kubectl get nodes
kubectl get pods -A
kubectl get namespaces
```

---

# Azure SQL Database Integration

Initially:

* Application data was temporary inside pod runtime memory.

Problem:

* Data lost during restart/redeployment.

Solution:

* Azure SQL Database integration.

Application Flow:

```text
Application Pod
      ↓
Connection String
      ↓
Azure SQL Database
```

Capabilities Achieved:

* Persistent application storage
* Enterprise relational database support
* Production-style backend architecture

---

# Monitoring & Observability

Monitoring Stack Includes:

* Azure Monitor
* Log Analytics Workspace
* Managed Prometheus
* Managed Grafana
* Container Insights
* AKS Diagnostics

Capabilities:

* Pod monitoring
* Node monitoring
* Metrics visualization
* Deployment diagnostics
* Operational troubleshooting

---

# AKS Operational Model

## Day-1 Operations

Includes:

* AKS provisioning
* Monitoring setup
* Namespace creation
* RBAC configuration
* Helm enablement

---

## Day-2 Operations

Includes:

* Helm upgrades
* Rollout validation
* Pod troubleshooting
* Log analysis
* Infrastructure updates
* Cluster rebuild lifecycle

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
* Kubernetes RBAC
* Namespace Isolation
* Azure RBAC
* Key Vault Integration
* Secure Terraform Backend
* Immutable Image Deployment

---

# Common Troubleshooting Areas

Common Operational Issues:

* Terraform backend initialization issues
* AKS authentication failures
* ACR image pull failures
* Helm deployment failures
* Kubernetes rollout failures
* Namespace permission issues
* Workload Identity issues
* Monitoring integration issues

---

# Enterprise Best Practices Implemented

* Modular Terraform architecture
* Environment isolation
* Namespace isolation
* Immutable image deployment
* Runtime validation
* Monitoring-first operational model
* Infrastructure disposability
* Secure secret management
* Passwordless authentication

---

# Deployment Prerequisites

Required Tools:

* Azure Subscription
* Azure DevOps Organization
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
* End-to-end Azure DevOps CI/CD
* Terraform modular infrastructure
* Kubernetes operational workflows
* Secure AKS deployment lifecycle
* Enterprise monitoring implementation
* Real-world platform engineering practices

---

# Conclusion

`employeeprofileapp-aks` provides a complete enterprise AKS platform engineering implementation combining Terraform Infrastructure as Code, Azure DevOps CI/CD, Helm-based Kubernetes deployments, Azure-native monitoring, Workload Identity integration, Azure SQL Database implementation, and enterprise Kubernetes operational practices.

The repository demonstrates scalable, reusable, secure, and production-style AKS deployment architecture aligned with modern enterprise cloud-native engineering standards.