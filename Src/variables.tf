variable "subscription_id" {
  description = "The Subscription ID for Azure"
  type        = string
}

variable "tags" {
  type = map(string)
  default = {
    environment = "QA"
  }
}

variable "env_name" {
  description = "The Environment prefix for Azure services"
  type        = string
  default     = "q" # Your environment name (eg. q, u, p)
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

variable "ghcr_pat" {
  description = "Github container registry access token"
  type        = string
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

variable "services_prefix" {
  description = "The prefix of each services (eg. Client Name)"
  type        = string
  default     = "aerish"
}

variable "database_admin_password" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}




# Cloudflare

variable "domain_name" {
  description = "Domain name"
  type        = string
  default     = "dagpin.com"
}

variable "cloudflare_api_key" {
  description = "API key for Cloudflare"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Zone ID for the Cloudflare domain"
  type        = string
  default       = "f59f0ce0899e670c1a23f4023fda759f"
}

variable "cloudflare_email" {
  description = "Email associated with Cloudflare account"
  type        = string
  default       = "vincent.dagpin@gmail.com"
}