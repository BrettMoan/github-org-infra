resource "github_repository" "this" {
  name                   = var.name
  description            = var.description
  visibility             = var.visibility
  has_issues             = var.has_issues
  has_wiki               = var.has_wiki
  has_projects           = var.has_projects
  auto_init              = var.auto_init
  allow_merge_commit     = var.allow_merge_commit
  allow_squash_merge     = var.allow_squash_merge
  allow_rebase_merge     = var.allow_rebase_merge
  delete_branch_on_merge = var.delete_branch_on_merge
  has_downloads          = var.has_downloads
  archive_on_destroy     = var.archive_on_destroy
}

resource "github_branch_protection" "this" {
  count = var.branch_protection != null ? 1 : 0

  repository_id                   = github_repository.this.node_id
  pattern                         = var.branch_protection.pattern
  enforce_admins                  = var.branch_protection.enforce_admins
  require_signed_commits          = var.branch_protection.require_signed_commits
  required_linear_history         = var.branch_protection.required_linear_history
  require_conversation_resolution = var.branch_protection.require_conversation_resolution

  dynamic "required_status_checks" {
    for_each = var.branch_protection.required_status_checks != null ? [var.branch_protection.required_status_checks] : []
    content {
      strict   = required_status_checks.value.strict
      contexts = required_status_checks.value.contexts
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = var.branch_protection.required_pull_request_reviews != null ? [var.branch_protection.required_pull_request_reviews] : []
    content {
      dismiss_stale_reviews           = required_pull_request_reviews.value.dismiss_stale_reviews
      restrict_dismissals             = required_pull_request_reviews.value.restrict_dismissals
      dismissal_restrictions          = required_pull_request_reviews.value.dismissal_restrictions
      pull_request_bypassers          = required_pull_request_reviews.value.pull_request_bypassers
      require_code_owner_reviews      = required_pull_request_reviews.value.require_code_owner_reviews
      required_approving_review_count = required_pull_request_reviews.value.required_approving_review_count
      require_last_push_approval      = required_pull_request_reviews.value.require_last_push_approval
    }
  }

  dynamic "restrict_pushes" {
    for_each = var.branch_protection.restrict_pushes != null ? [var.branch_protection.restrict_pushes] : []
    content {
      blocks_creations = restrict_pushes.value.blocks_creations
      push_allowances  = restrict_pushes.value.push_allowances
    }
  }
}

resource "github_repository_webhook" "this" {
  for_each = { for webhook in var.webhooks : webhook.url => webhook }

  repository = github_repository.this.name
  active     = each.value.active

  configuration {
    url          = each.value.url
    content_type = each.value.content_type
    insecure_ssl = each.value.insecure_ssl
    secret       = each.value.secret
  }

  events = each.value.events
}


# TODO: Add branch protection rules, webhooks, and other repository settings as needed.
