# single-namespace-rename

This module allows you to easily reference k8s resources that were synced back to host cluster by vcluster when using single namespace deployment mode.

## Outputs

- `name` - synced back k8s resource name

## Usage

```hcl
module "my_k8s_resource" {
  source        = "github.com/loft-sh/vcluster-terraform-modules//single-namespace-rename"
  resource_name = "my-resource-name"
  namespace     = "my-namespace"
  vcluster_name = "my-vcluster"
}

output "updated_name" {
  value = module.my_k8s_resource.name
}
```
