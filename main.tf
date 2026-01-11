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

locals {
  repos = jsondecode(file("${path.module}/repos/repos.json"))
}

module "repos" {
  source      = "./modules/repo"
  for_each    = { for repo in local.repos : repo.name => repo }
  name        = each.value.name
  description = each.value.description
  visibility  = each.value.visibility
  has_issues  = each.value.has_issues
  has_wiki    = each.value.has_wiki
  has_projects = each.value.has_projects
  auto_init   = each.value.auto_init
}

import {
  to = module.repos["github-org-infra"].github_repository.this
  id = "github-org-infra"
}

import {
  to = module.repos["iam-oidc-permissions"].github_repository.this
  id = "iam-oidc-permissions"
}

import {
  to = module.repos["frontend-app"].github_repository.this
  id = "frontend-app"
}

import {
  to = module.repos["network-config"].github_repository.this
  id = "network-config"
}

import {
  to = module.repos["backend-api"].github_repository.this
  id = "backend-api"
}

import {
  to = module.repos["reporting-analytics"].github_repository.this
  id = "reporting-analytics"
}
