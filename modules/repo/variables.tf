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
