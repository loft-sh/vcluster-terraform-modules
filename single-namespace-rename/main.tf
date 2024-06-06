data "external" "hash" {
  program = [
    "/bin/bash",
    "-c",
    <<EOT
    input="${var.resource_name}-x-${var.namespace}-x-${var.vcluster_name}"
    hash=$(echo -n "$input" | sha256sum | awk '{print $1}')
    echo "{\"hash\": \"$hash\"}"
    EOT
  ]
}

locals {
  concatenated_name = "${var.resource_name}-x-${var.namespace}-x-${var.vcluster_name}"
  hash              = data.external.hash.result.hash
  digest            = substr(local.hash, 0, 10)
  safe_name         = length(local.concatenated_name) > 63 ? "${substr(local.concatenated_name, 0, 52)}-${local.digest}" : local.concatenated_name
  final_name        = replace(local.safe_name, ".-", "-")
}
