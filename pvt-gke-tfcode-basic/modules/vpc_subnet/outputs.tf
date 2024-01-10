output "vpcname" {
  value = data.google_compute_network.vpc.name
}
output "subnetname" {
  value = google_compute_subnetwork.subnet.name
}
