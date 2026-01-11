# github-org-infra

This repository manages GitHub organization infrastructure using Terraform. It automates the creation and configuration of repositories, teams, branch protections, and secrets to demonstrate best practices in GitHub org management and Infrastructure as Code (IaC).

## Features
- Automated repo creation and configuration
- Team and permission management
- Branch protection and secret automation
- Designed for OIDC-based GitHub Actions workflows

## How to Use
1. Fork or clone this repo.
2. Configure your GitHub provider credentials (OIDC or PAT).
3. Update Terraform files as needed.
4. Use the included GitHub Actions workflow for CI/CD.

## Part of a Multi-Repo Demo
This repo is part of a larger, opinionated infrastructure demonstration. See the [brettmoan main overview](https://github.com/brettmoan/README.md) for the full architecture and design rationale.

---

*For questions or improvements, open an issue or PR!*
