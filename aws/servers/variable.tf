// Variables

variable "aws_profile" {
  type        = "map"
  description = "AWS profile"

  default = {
    stage = "dawitnida"
    prod  = "superdawit"
  }
}

variable "aws_region" {
  type = "map"

  default = {
    stage = "eu-west-1"
    prod  = "us-west-1"
  }

  description = "AWS region to launch instances"
}

variable "ami_id" {
  type        = "string"
  description = "The name of the image for the deployment."
  default     = "ami-047bb4163c506cd98"
}

variable "server_port" {
  type        = "string"
  description = "The port the server will use for HTTP requests"
  default     = 8080
}
