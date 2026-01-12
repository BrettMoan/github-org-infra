locals {
  repos = jsondecode(file("${path.module}/repos/repos.json"))
}

module "repos" {
  source       = "./modules/repo"
  for_each     = { for repo in local.repos : repo.name => repo }
  name         = each.value.name
  description  = each.value.description
  visibility   = each.value.visibility
  has_issues   = each.value.has_issues
  has_wiki     = each.value.has_wiki
  has_projects = each.value.has_projects
  auto_init    = each.value.auto_init
}
