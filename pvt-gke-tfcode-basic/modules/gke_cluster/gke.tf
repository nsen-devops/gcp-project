# GKE cluster
data "google_container_engine_versions" "gke_version" {
  location       = var.location
  version_prefix = "1.27."
}

resource "google_container_cluster" "primary" {
  name     = "${var.cluster_name}"
  location = "${var.location}"

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = "${var.vpc_name}"
  subnetwork = "${var.subnet_name}"

  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes   = true 
    master_ipv4_cidr_block = "${var.cluster_master_cidr}"
  }
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "${var.cluster_pod_cidr}"
    services_ipv4_cidr_block = "${var.cluster_service_cidr}"
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "${var.cluster_authrized_cidr}"
      display_name = "net1"
    }
  }
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name     = google_container_cluster.primary.name
  location = var.location
  cluster  = google_container_cluster.primary.name

  version    = data.google_container_engine_versions.gke_version.release_channel_latest_version["STABLE"]
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    # preemptible  = true
    machine_type = "n1-standard-1"
    disk_type    = "${var.worker_node_disk_type}"
    disk_size_gb = "${var.worker_node_disk_size}"
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}


