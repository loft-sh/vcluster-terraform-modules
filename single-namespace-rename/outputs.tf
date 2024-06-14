output "name" {
  description = "The value of the 'name' key from the 'status' struct in the response of the POST request"
  value       = local.response_data["status"]["name"]
}

output "response_code" {
  description = "The HTTP response code from the POST request"
  value       = data.http.post_request.status_code
}

output "response_body" {
  description = "The full JSON response body from the POST request"
  value       = data.http.post_request.response_body
}
