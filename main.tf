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

  # Additional repository settings (optional)
  allow_merge_commit     = try(each.value.allow_merge_commit, true)
  allow_squash_merge     = try(each.value.allow_squash_merge, true)
  allow_rebase_merge     = try(each.value.allow_rebase_merge, true)
  delete_branch_on_merge = try(each.value.delete_branch_on_merge, false)
  has_downloads          = try(each.value.has_downloads, true)
  archive_on_destroy     = try(each.value.archive_on_destroy, true)

  # Branch protection (optional)
  branch_protection = try(each.value.branch_protection, null)

  # Webhooks (optional)
  webhooks = try(each.value.webhooks, [])
}
