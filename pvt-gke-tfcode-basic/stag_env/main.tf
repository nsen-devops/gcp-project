module "vpc_subnet" {
  source            = "../modules/vpc_subnet"
  vpc_name          = "gke-cluster-vpc"
  subnet_name       = "gke-cluster-subnet"
  subnet_cidr_range = "10.10.1.0/24"
  region            = "${var.region}"
}

module "my_gke_cluster" {
  source                 = "../modules/gke_cluster"
  project_id             = "${var.project_id}"
  region                 = "${var.region}"
  location               = "${var.location}"
  gke_num_nodes          = "1"
  cluster_name           = "my-tf-gke-cluster"
  cluster_master_cidr    = "10.13.0.0/28"
  cluster_pod_cidr       = "10.11.0.0/21"
  cluster_service_cidr   = "10.12.0.0/21"
  cluster_authrized_cidr = "10.0.10.10/32"
  worker_node_disk_type  = "pd-balanced"
  worker_node_disk_size  = "20"
  vpc_name               = module.vpc_subnet.vpcname
  subnet_name            = module.vpc_subnet.subnetname
  depends_on             = [module.vpc_subnet]
}
