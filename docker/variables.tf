// Variables

variable "docker_host" {
  default     = "unix:///var/run/docker.sock"
  description = "Docker host"
}

variable "bucket" {}
variable "key" {}

variable "aws_profile" {
  default     = "dawitnida"
  description = "AWS profile"
}

variable "aws_access_key_id" {
  default     = ""
  description = "AWS secret key"
}

variable "aws_secret_access_key" {
  default     = ""
  description = "AWS secret key"
}

variable "aws_region" {
  default     = "eu-west-1"
  description = "AWS region to launch instances"
}

variable "aws_zones" {
  type        = "list"
  description = "List of availability zones to use"
  default     = ["eu-west-1"]
}

variable "image" {
  default     = "nginx:latest"
  description = "Nginx image"
}
