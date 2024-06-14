variable "url" {
  description = "The URL to send the POST request to"
  type        = string
}

variable "auth_token" {
  description = "The authorization token to be passed in the POST request"
  type        = string
}

variable "resource_name" {
  description = "Value for spec.name in the JSON payload"
  type        = string
}

variable "resource_namespace" {
  description = "Value for spec.namespace in the JSON payload"
  type        = string
}

variable "vcluster_name" {
  description = "Value for spec.vclusterName in the JSON payload"
  type        = string
}
