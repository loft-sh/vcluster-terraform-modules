locals {
  concatenated_name = "${var.resource_name}-x-${var.namespace}-x-${var.vcluster_name}"
  hash              = base64encode(sha256(local.concatenated_name))
  digest            = substr(local.hash, 0, 10)
  safe_name         = length(local.concatenated_name) > 63 ? "${substr(local.concatenated_name, 0, 52)}-${local.digest}" : local.concatenated_name
  final_name        = replace(local.safe_name, ".-", "-")
}
