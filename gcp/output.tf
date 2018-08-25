# Outputs

output "instance_id" {
  value = "${google_compute_instance.gcp-dev-default.self_link}"
}
