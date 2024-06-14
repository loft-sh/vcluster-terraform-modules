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

data "http" "post_request" {
  provider = http.default
  url      = var.url
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
