variable "name" {}
variable "env" {}
variable "kube-master-version" {}
variable "kube-node-version" {}
variable "node-number" {}
variable "node-type" {}
variable "region" {}
variable "network" {}
variable "preemptible" {}
variable "master_cidr" {}
variable "authorized_cidr" {}
variable "subnetwork_node_cidr" {}
variable "subnetwork_pod_cidr" {}
variable "subnetwork_svc_cidr" {}
variable "ssh_public_key" {}

// NAT GATEWAY VARIABLES
variable "proxy_count" {}

variable "proxy_image" {}
variable "proxy_machine_type" {}

// GLUSTERD VARIABLES
variable "glusterd_count" {}

variable "glusterd_machine_type" {}
variable "glusterd_disk_dimension" {}
variable "glusterd_ip_offset" {}
variable "glusterd_image" {}

data "google_compute_zones" "available" {
  region = "${var.region}"
}
