variable "glusterd-machine-type" {
  default     = "n1-standard-1"
  description = "VM size of glusterd nodes"
}

variable "glusterd-disk-dimension" {
  default     = 300
  description = "Dimension of xternal disk to be used by heteti to provision PVC"
}

variable "glusterd-ip-offset" {
  default = 1024
}

variable "glusterd-image" {
  default = ""
}

variable "subnetwork" {
  descrption = "self_link of subnetwork to add gluster machines in"
}

variable "name" {}

variable "env" {}

variable "root-ssh-publickey" {
  descriptio = "path to public key to use for root user"
}

variable "region" {
  default = "europe-west1"
}

data "google_compute_zones" "available" {
  region = "${var.region}"
}
