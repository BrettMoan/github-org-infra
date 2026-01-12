output "repository" {
  value = github_repository.this
}

output "branch_protection" {
  value       = var.branch_protection != null ? github_branch_protection.this[0] : null
  description = "Branch protection configuration"
}

output "webhooks" {
  value       = github_repository_webhook.this
  description = "Repository webhooks"
  sensitive   = true
}
