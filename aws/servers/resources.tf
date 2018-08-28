// Configure provider and credentials
terraform {
  backend "s3" {}
}

provider "aws" {
  profile = "${var.aws_profile["stage"]}"
  region  = "${var.aws_region["stage"]}"
}

resource "aws_security_group" "sg_dev_server" {
  name        = "dev-allow-all"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = "${var.server_port}"
    to_port     = "${var.server_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "sg-dev-server"
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
    Name = "dev-instance"
    Type = "staging"
  }
}
