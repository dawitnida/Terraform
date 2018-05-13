# Outputs

output "instance_id" {
  value = "${google_compute_instance.gcloud-dev-default.self_link}"
}