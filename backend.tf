terraform {
  cloud {
    organization = "brettmoan"
    workspaces {
      name = "github-org-infra"
    }
  }

  required_version = ">= 1.0.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 5.0.0"
    }
  }
}


provider "github" {
  # Configure via OIDC or PAT in GitHub Actions
}
