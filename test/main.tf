locals {
  test_cases = jsondecode(file("${path.module}/test_cases.json"))
}

resource "null_resource" "test_cases" {
  count = length(local.test_cases)

  triggers = {
    resource_name = local.test_cases[count.index].resource_name
    namespace     = local.test_cases[count.index].namespace
    vcluster_name = local.test_cases[count.index].vcluster_name
  }

  provisioner "local-exec" {
    command = "echo ${module.my_k8s_resource[count.index].name} > result_${count.index}.txt"
  }
}

module "my_k8s_resource" {
  count         = length(local.test_cases)
  source        = "../single-namespace-rename"
  resource_name = local.test_cases[count.index].resource_name
  namespace     = local.test_cases[count.index].namespace
  vcluster_name = local.test_cases[count.index].vcluster_name
}

output "updated_names" {
  value = {
    for idx, tc in local.test_cases :
    idx => {
      resource_name  = tc.resource_name
      namespace      = tc.namespace
      vcluster_name  = tc.vcluster_name
      updated_name   = module.my_k8s_resource[idx].name
    }
  }
}
