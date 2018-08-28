output "instance_id" {
  description = "EC2 instance ID"
  value       = "${aws_instance.dn_dev_server.id}"
}

output "private_ip" {
  description = "Private IP address for instance"
  value       = "${aws_instance.dn_dev_server.private_ip}"
}

output "public_ip" {
  description = "Public IP address for instance"
  value       = "${aws_instance.dn_dev_server.public_ip}"
}
