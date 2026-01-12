variable "name" {
  description = "Name of the repository"
  type        = string
}

variable "description" {
  description = "Description of the repository"
  type        = string
  default     = ""
}

variable "visibility" {
  description = "Repository visibility: public or private"
  type        = string
  default     = "private"
}

variable "has_issues" {
  description = "Enable GitHub Issues?"
  type        = bool
  default     = true
}

variable "has_wiki" {
  description = "Enable GitHub Wiki?"
  type        = bool
  default     = false
}

variable "has_projects" {
  description = "Enable GitHub Projects?"
  type        = bool
  default     = false
}

variable "auto_init" {
  description = "Auto-initialize the repository with a README?"
  type        = bool
  default     = true
}

# Additional repository settings
variable "allow_merge_commit" {
  description = "Allow merge commits?"
  type        = bool
  default     = true
}

variable "allow_squash_merge" {
  description = "Allow squash merging?"
  type        = bool
  default     = true
}

variable "allow_rebase_merge" {
  description = "Allow rebase merging?"
  type        = bool
  default     = true
}

variable "delete_branch_on_merge" {
  description = "Automatically delete head branches after PRs are merged?"
  type        = bool
  default     = false
}

variable "has_downloads" {
  description = "Enable the Downloads feature?"
  type        = bool
  default     = true
}

variable "archive_on_destroy" {
  description = "Archive the repository instead of deleting on destroy?"
  type        = bool
  default     = true
}

# Branch protection variables
variable "branch_protection" {
  description = "Branch protection configuration"
  type = object({
    pattern                         = string
    enforce_admins                  = optional(bool, false)
    require_signed_commits          = optional(bool, false)
    required_linear_history         = optional(bool, false)
    require_conversation_resolution = optional(bool, false)
    required_status_checks = optional(object({
      strict   = optional(bool, false)
      contexts = optional(list(string), [])
    }), null)
    required_pull_request_reviews = optional(object({
      dismiss_stale_reviews           = optional(bool, true)
      restrict_dismissals             = optional(bool, false)
      dismissal_restrictions          = optional(list(string), [])
      pull_request_bypassers          = optional(list(string), [])
      require_code_owner_reviews      = optional(bool, false)
      required_approving_review_count = optional(number, 1)
      require_last_push_approval      = optional(bool, false)
    }), null)
    restrict_pushes = optional(object({
      blocks_creations = optional(bool, false)
      push_allowances  = optional(list(string), [])
    }), null)
  })
  default = null
}

# Webhook variables
variable "webhooks" {
  description = "List of webhooks to configure for the repository"
  type = list(object({
    url          = string
    content_type = optional(string, "json")
    insecure_ssl = optional(bool, false)
    active       = optional(bool, true)
    events       = list(string)
    secret       = optional(string, null)
  }))
  default = []
}
