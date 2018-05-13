
// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("~/.gcloud/gcp-project-203519.json")}"
  project     = "${var.project}"
  region      = "${var.region1}"
}

// Create a new instance
resource "google_compute_instance" "gcloud-dev-default" {
  name         = "gcloud-dev-terraform-instance"
  machine_type = "f1-micro"
  zone         = "${var.zone}"
  tags         = ["http-dev-env", "terraform-dev"]

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

