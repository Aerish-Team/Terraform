variable "name_prefix" {
    description = "The prefix for the names of resources"
    type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group"
  type        = string
}

variable "ghcr_url" {
  description = "Github container registry url"
  type        = string
  default     = "ghcr.io"
}

variable "ghcr_username" {
  description = "Github container registry username"
  type        = string
  default     = "vgdagpin"
}

variable "aerish_version_api" {
  description = "The version of aerish API"
  type        = string
  default     = "latest"
}

variable "aerish_version_admin" {
  description = "The version of aerish Admin"
  type        = string
  default     = "latest"
}

variable "aerish_version_reports" {
  description = "The version of aerish Reports"
  type        = string
  default     = "latest"
}

variable "aerish_version_eportal" {
  description = "The version of aerish EPortal"
  type        = string
  default     = "latest"
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace"
  type        = string
}

variable "server_shared_identity_id" {
  description = "The User Assigned Identity for the Container App"
  type        = string
}

variable "keyvault_db_connection_string_id" {
  description = "The Key Vault secret ID for the database connection string"
  type        = string
}

variable "keyvault_ghcr_path_id" {
  description = "The Key Vault secret ID for the GHCR path"
  type        = string
}

variable "application_insights_connection_string" {
  description = "The connection string for Application Insights"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}