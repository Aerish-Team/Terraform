terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

# resource "cloudflare_record" "api_cname" {
#   zone_id = var.cloudflare_zone_id
#   name    = "${local.name_prefix}-api"
#   value   = azurerm_container_app.api.latest_revision_fqdn
#   type    = "CNAME"
#   ttl     = 300
#   proxied = false
# }

# resource "cloudflare_record" "api_TXT" {
#   zone_id = var.cloudflare_zone_id
#   name    = "asuid.${local.name_prefix}-api.${var.domain_name}"
#   value   = "\"${azurerm_container_app.api.custom_domain_verification_id}\""
#   type    = "TXT"
#   ttl     = 300
# }

# output "ApiUrl" {
#   value = "${cloudflare_record.api_cname.name}.${var.domain_name}"
# }
