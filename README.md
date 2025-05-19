# Infrastructure as Code (IaC)

This repository contains Terraform configurations and supporting scripts to provision, manage, and maintain the organization's cloud infrastructure on **AWS**. It enables consistent, repeatable, and version-controlled deployments across multiple environments, including development, staging, and production.

**Ansible** is used for configuration management, automating system setup and post-provisioning tasks.

While the current focus is on AWS, the repository is structured with future **multi-cloud support** in mind, enabling seamless integration with other cloud platforms as infrastructure needs evolve.

All changes are tracked in **Git** and follow a structured **CI/CD pipeline**, ensuring secure, auditable, and reliable infrastructure updates.

---

## 🧱 Infrastructure Overview

The following resources are provisioned and managed via Terraform:

- Identity Access Management (IAM) Users, Groups and Roles
- VPCs, Subnets (Private and Public), Internet Gateways and Route Tables
- EC2 Instances
- Security Groups
- S3 Buckets (for remote state backend management)
- RDS Databases
- Elastic Load Balancers
- Auto Scaling Groups

_Configuration and application setup on instances is managed via Ansible._

---

## 🗺️ Architecture Diagram


> This diagram provides a high-level overview of the infrastructure components and their relationships. It is designed to be accessible to both technical and non-technical stakeholders.

---

## 📂 Directory Structure

```text
.
├── modules/            # Reusable Terraform modules
├── environments/
│   ├── dev/
│   ├── staging/
│   └── production/
├── ansible/            # Ansible playbooks and roles
├── scripts/            # Helper or provisioning scripts
└── README.md
