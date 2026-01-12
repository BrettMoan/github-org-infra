output "repository" {
  value = github_repository.this
}

output "branch_protection" {
  value       = one(github_branch_protection.this)
  description = "Branch protection configuration"
}

output "webhooks" {
  value       = github_repository_webhook.this
  description = "Repository webhooks"
  sensitive   = true
}
