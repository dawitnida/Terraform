// Configure provider and credentials
provider "aws" {
  profile    = "${var.aws_profile}"
  access_key = "${var.aws_access_key}"
  secret_key = "S{var.aws_secret_key}"
  region     = "eu-central-1"
}

// Create AWS instance
resource "aws_instance" "aws-dev-terraform-instance" {
  ami           = "ami-5652ce39"
  instance_type = "t1.micro"
}
