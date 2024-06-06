locals {
  test_cases = jsondecode(file("${path.module}/test_cases.json"))
}

module "my_k8s_resource" {
  count         = length(local.test_cases)
  source        = "../single-namespace-rename"
  resource_name = local.test_cases[count.index].resource_name
  namespace     = local.test_cases[count.index].namespace
  vcluster_name = local.test_cases[count.index].vcluster_name
}

output "updated_names" {
  value = [
    for idx in range(length(local.test_cases)) : {
      resource_name  = local.test_cases[idx].resource_name
      namespace      = local.test_cases[idx].namespace
      vcluster_name  = local.test_cases[idx].vcluster_name
      updated_name   = module.my_k8s_resource[idx].name
    }
  ]
}
