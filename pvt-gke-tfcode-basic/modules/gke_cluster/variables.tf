variable "project_id" {
  default     = ""
  description = "project id"
}
variable "region" {
  default     = ""
}
variable "location" {
  default     = ""
}
variable "gke_num_nodes" {
  default     = ""
  description = "number of gke nodes"
}
variable "cluster_name" {
  default     = ""
}
variable "cluster_master_cidr" {
  default     = ""
}
variable "cluster_pod_cidr" {
  default     = ""
}
variable "cluster_service_cidr" {
  default     = ""
}
variable "cluster_authrized_cidr" {
  default     = ""
}
variable "worker_node_disk_type" {
  default     = ""
}
variable "worker_node_disk_size" {
  default     = ""
}
variable "vpc_name" {
  default     = ""
}
variable "subnet_name" {
  default     = ""
}