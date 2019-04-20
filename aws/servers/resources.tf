// Configure provider and credentials
terraform {
  backend "s3" {}
}

locals {
  profile = "${terraform.workspace == "prod" ? var.aws_profile["dn-prod"] : var.aws_profile["dn-stage"]}"
  region  = "${terraform.workspace == "prod" ? var.aws_region["dn-prod"] : var.aws_region["dn-stage"]}"
}

provider "aws" {
  profile = "${local.profile}"
  region  = "${local.region}"
}

resource "aws_security_group" "sg_dev_server" {
  name        = "${terraform.workspace}-allow-all"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = "${var.server_port}"
    to_port     = "${var.server_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name    = "sg-dev-server"
    profile = "${local.profile}"
    region  = "${local.region}"
  }
}

// Create AWS instance
resource "aws_instance" "dn_dev_server" {
  ami           = "${var.ami_id}"
  instance_type = "t1.micro"

  vpc_security_group_ids = ["${aws_security_group.sg_dev_server.id}"]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, Terraform" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  tags {
    Name    = "dev-instance"
    Type    = "staging"
    profile = "${local.profile}"
    region  = "${local.region}"
  }
}
