# employeeprofileapp

Real Enterprise AKS Platform Engineering Repository

---

# Platform Architecture Overview

This repository implements a real-world AKS platform engineering model using:

- Terraform
- Azure Kubernetes Service (AKS)
- Helm
- Azure DevOps
- Azure Monitor
- Managed Prometheus
- Managed Grafana

The repository follows an environment-first deployment architecture supporting:

- DEV
- QA
- UAT
- PROD

---

# Terraform Responsibilities

Terraform manages platform-level infrastructure components.

## Infrastructure Components

- AKS Infrastructure
- Networking
- Namespace Management
- Governance
- RBAC
- Secrets
- Monitoring
- Ingress Governance

## Terraform Features

- Remote State Management
- Environment Separation
- Modular Infrastructure Design
- Reusable Terraform Modules
- AKS Validation
- Monitoring Integration

---

# Helm Responsibilities

Helm manages Kubernetes application deployment components.

## Helm Components

- Application Deployments
- Services
- HPA
- ConfigMaps
- Application Ingress

## Helm Features

- Environment-Based Values Files
- Optional HPA Framework
- Optional Ingress Framework
- TLS Readiness Framework
- Probe Readiness Framework
- Scheduling Readiness Framework

---

# Azure DevOps Responsibilities

Azure DevOps manages CI/CD automation.

## Pipeline Types

- Infrastructure Pipelines
- CI Pipelines
- CD Pipelines

## CI/CD Features

- Docker Build Automation
- Image Versioning
- Helm Deployment Automation
- Terraform Deployment Automation
- AKS Validation
- Rollback Readiness

---

# Monitoring Stack

Monitoring is integrated using Azure-native observability services.

## Monitoring Components

- Azure Monitor
- Log Analytics Workspace
- Managed Prometheus
- Managed Grafana

---

# Repository Structure

```text
terraform/
helm/
src/
azure-pipelines/