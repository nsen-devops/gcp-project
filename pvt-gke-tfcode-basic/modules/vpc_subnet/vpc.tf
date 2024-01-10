# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.vpc_name}"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.subnet_name}"
  region        = "${var.region}"
  network       = google_compute_network.vpc.name
  ip_cidr_range = "${var.subnet_cidr_range}"
}
