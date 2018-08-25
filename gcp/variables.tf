# Set variables

variable "project" {
  default     = "gcp-project-203519"
  description = "Project alpha google cloud project"
}

variable "region1" {
  default = "europe-west1"
}

variable "zone" {
  default = "europe-west1-b"
}

variable "machine_type" {
  default = "f1-micro"
}
