variable "name" {}
variable "env" {}
variable "kube_master_version" {}
variable "kube_node_version" {}

variable "node_pools" {
  type = "list"

  default = [
    {
      name = "app"
    },
  ]
}

variable "node_taints" {
  type = "map"

  default = {}
}

variable "node_number" {
  default = 1
}

variable "node_type" {
  default = "n1-standard-1"
}

variable "node_os" {
  default = "UBUNTU"
}

variable "region" {
  default = "europe-west1"
}

variable "subnetwork_master_cidr" {
  default = "10.20.0.0/28"
}

variable "master_authorized_cidr_blocks" {
  type = "list"

  default = [
    {
      cidr_block   = "0.0.0.0/0"
      display_name = "default"
    },
  ]
}

variable "daily_maintenance_time" {
  default = "04:00"
}

variable "subnetwork_node_cidr" {
  default = "10.1.0.0/16"
}

variable "subnetwork_pod_cidr" {
  default = "10.3.0.0/16"
}

variable "subnetwork_svc_cidr" {
  default = "10.5.0.0/16"
}

data "google_compute_zones" "available" {
  region = "${var.region}"
}

variable "infra_node_number" {
  default = 1
}

variable "infra_node_type" {
  default = "n1-standard-1"
}

variable "infra_node_os" {
  default = "COS"
}

variable "bastion_count" {
  default = 1
}

variable "bastion_machine_type" {
  default = "g1-small"
}

data "google_compute_image" "bastion" {
  family  = "ubuntu-1804-lts"
  project = "ubuntu-os-cloud"
}

variable "bastion_ssh_enabled" {
  type        = "string"
  default     = true
  description = "disabling this will block all the INGRESS traffic on port 22 of the bastion instances"
}

variable "bastion_vpn_enabled" {
  type        = "string"
  default     = true
  description = "disabling this will block all the INGRESS traffic on port 1194 of the bastion instances"
}
