output "sg_id" {
  description = "EC2 instance ID"
  value       = "${aws_security_group.sg_dev_server.id}"
}
