// Variables

variable "aws_profile" {
  default     = "dawitnida"
  description = "AWS profile"
}
variable "aws_access_key" {
   default     = ""
   description = "AWS Access key"
}

variable "aws_secret_key" {
   default     = ""
   description = "AWS Secret access key"
}

variable "aws_region" {
   default     = "eu-central-1"
   description = "AWS region to launch instances"
}
