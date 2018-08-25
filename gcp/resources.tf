// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("~/.gcp/gcp-project-203519-a20bbf5b5e13.json")}"
  project     = "${var.project}"
  region      = "${var.region1}"
}

resource "google_compute_network" "gcp_dev_network" {
  name                    = "dev-network"
  auto_create_subnetworks = true
}

// Create a new instance
resource "google_compute_instance" "gcp_dev_default" {
  name         = "gcp-dev-tf"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  tags         = ["http-dev-env", "gcp-tf-dev"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
