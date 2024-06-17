# single-namespace-rename

This module allows you to easily reference k8s resources that were synced back to host cluster by vcluster when using single namespace deployment mode.

## Providers

This module requires `http` provider to be passed to it.

## Variables

- `host` - vCluster Platform host.
- `auth_token` - Auth token for vCluster Platform API.
- `resource_name` - Name of k8s resource deployed within virtual cluster.
- `resource_namespace` - Namespace of k8s resource within virtual cluster.
- `vcluster_name` - Name of virtual cluster hosting the resource.

## Outputs

- `name` - Synced back k8s resource name.
- `response_code` - Response status code.
- `response_body` - Full json response body.

## Usage

```hcl
provider "http" {
    alias = "default"
}

module "my_k8s_resource" {
  source        = "github.com/loft-sh/vcluster-terraform-modules//single-namespace-rename"

  providers = {
    http.default = http.default
  }


  host                = "https://localhost:8080"
  auth_token          = var.auth_token
  resource_name       = var.service_account_name
  resource_namespace  = var.service_account_namespace
  vcluster_name       = var.vcluster_name
}


output "updated_name" {
  value = module.my_k8s_resource.name
}
```
