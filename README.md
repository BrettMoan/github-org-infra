# github-org-infra

This repository manages GitHub organization infrastructure using Terraform. It automates the creation and configuration of repositories, teams, branch protections, and secrets to demonstrate best practices in GitHub org management and Infrastructure as Code (IaC).

## Features
- Automated repo creation and configuration
- Leverages Terraform cloud VCS intergartion for free state management (important as the cloud is not setup yet as the repo where cloud will be configured doesn't exist until this has been setup)

## Part of a Multi-Repo Demo
This repo is part of a larger, opinionated infrastructure demonstration. See the [brettmoan main overview](https://github.com/brettmoan/README.md) for the full architecture and design rationale.

---

## Setup Steps


1. **Create a GitHub Personal Access Token (PAT):**
	- Go to [GitHub Settings → Developer settings → Personal access tokens](https://github.com/settings/tokens).
	- Click "Generate new token" and select the `repo` scope.
	- Copy and store the PAT securely.

2. **Run locally via Terraform (no remote state):**
	- Remove or comment out the `terraform { cloud { ... } }` block from `main.tf`.
	- Ensure the `terraform { required_providers { ... } }` block is present.
	- Store the PAT securely on your local machine (e.g., as an environment variable: `export GITHUB_TOKEN=your_pat` on Linux/macOS, or `$env:GITHUB_TOKEN = 'your_pat'` on Windows PowerShell).
	- The provider will automatically use the `GITHUB_TOKEN` environment variable if the `token` argument is not set.
	- Run `terraform init` and `terraform apply` locally.

2. **Set up a Terraform Cloud organization:**
	- Go to [Terraform Cloud](https://app.terraform.io/) and sign up or log in.
	- Create a new organization (e.g., `brettmoan`).

3. **Add the PAT to Terraform Cloud workspace variables:**
	- In Terraform Cloud, go to your workspace (e.g., `github-org-infra`).
	- Navigate to "Variables" and add a new environment variable named `GITHUB_TOKEN`.
	- Paste your GitHub PAT (with `repo` scope) and mark it as sensitive.


5. **Configure Automatic Run Triggering:**
	- In your Terraform Cloud workspace, go to Settings → Version Control.
	- Under "Automatic Run Triggering," select "Only trigger runs when files in specified paths change."
	- Add the following path filters:
	  ```
	  *.tf
	  **/*.tf
	  *.json
	  **/*.json
	  ```
	- This ensures runs only trigger when .tf or .json files (including those in subdirectories) change.
    - make sure to click "update VCS settings" button or the settings are not applied
