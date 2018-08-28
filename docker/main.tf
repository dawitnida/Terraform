# Configure Docker provider and connect to the local Docker socket
terraform {
  backend "s3" {}
}

provider "docker" {
  host = "${var.docker_host}"
}

# Create a container
resource "docker_container" "docker_dev_nginx" {
  image = "${docker_image.nginx.latest}"
  name  = "dev-nginx-doc"

  ports {
    internal = 8082
    external = 8082
  }

  restart = "no"
}

resource "docker_image" "nginx" {
  name = "${var.image}"
}
