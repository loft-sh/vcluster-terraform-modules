# vcluster-terraform-modules

This repository contains ready to use Terraform modules that will make working with vCluster easier.

## Available modules

- [single-namespace-rename](single-namespace-rename/README.md)

## How to use

You can import given module into your terraform using git:

```hcl
provider "http" {
    alias = "default"
}

module "my_k8s_resource" {
  source        = "github.com/loft-sh/vcluster-terraform-modules//single-namespace-rename"

  providers = {
    http.default = http.default
  }


  host                = var.vcluster_platform_host
  access_key          = var.access_key
  resource_name       = var.service_account_name
  resource_namespace  = var.service_account_namespace
  vcluster_name       = var.vcluster_name
}


output "updated_name" {
  value = module.my_k8s_resource.name
}
```
