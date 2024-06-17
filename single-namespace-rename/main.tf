terraform {
  required_providers {
    http = {
       source = "hashicorp/http"
       configuration_aliases = [
         http.default,
       ]
    }
  }
}


locals {
  resource_path = "/kubernetes/management/apis/management.loft.sh/v1/singlenamespacename"
  host_with_scheme = length(regexall("^(http|https)://", var.host)) > 0 ? var.host : "https://${var.host}"
  sanitized_host = replace(local.host_with_scheme, "/+$", "")
  full_url = "${local.sanitized_host}${local.resource_path}"
}


data "http" "post_request" {
  provider = http.default
  url      = local.full_url
  insecure = true
  request_headers = {
    "Content-Type"  = "application/json"
    "Authorization" = "Bearer ${var.auth_token}"
  }

  request_body = jsonencode({
    spec = {
      name         = var.resource_name
      namespace    = var.resource_namespace
      vclusterName = var.vcluster_name
    }
  })
  method = "POST"
}

locals {
  response_data = jsondecode(data.http.post_request.response_body)
}
