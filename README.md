# vcluster-terraform-modules

This repository contains ready to use Terraform modules that will make working with vCluster easier.

## Available modules

- [single-namespace-rename](single-namespace-rename/README.md)

## How to use

You can import given module into your terraform using git:

```hcl
module "my_k8s_resource" {
  source        = "github.com/loft-sh/vcluster-terraform-modules//single-namespace-rename"
  resource_name = "my-resource-name"
  namespace     = "my-namespace"
  vcluster_name = "my-vcluster"
}
```
