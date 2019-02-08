variable "name" {}
variable "env" {}
variable "kube-master-version" {}
variable "kube-node-version" {}

variable "node-number" {
  default = 1
}

variable "node-type" {
  default = "n1-standard-1"
}

variable "node-os" {
  default = "UBUNTU"
}

variable "region" {
  default = "europe-west1"
}

variable "subnetwork-master-cidr" {
  default = "10.20.0.0/28"
}

variable "master-authorized-cidr" {
  default = "0.0.0.0/0"
}

variable "subnetwork-node-cidr" {
  default = "10.1.0.0/16"
}

variable "subnetwork-pod-cidr" {
  default = "10.3.0.0/16"
}

variable "subnetwork-svc-cidr" {
  default = "10.5.0.0/16"
}

data "google_compute_zones" "available" {
  region = "${var.region}"
}

variable "infra-node-number" {
  default = 1
}

variable "infra-node-type" {
  default = "n1-standard-1"
}

variable "infra-node-os" {
  default = "COS"
}

variable "bastion-count" {
  default = 1
}

variable "bastion-machine-type" {
  default = "g1-small"
}

data "google_compute_image" "bastion" {
  family  = "ubuntu-1804-lts"
  project = "ubuntu-os-cloud"
}

variable "bastion-ssh-enabled" {
  type        = "string"
  default     = true
  description = "disabling this will block all the INGRESS traffic on port 22 of the bastion instances"
}

variable "bastion-vpn-enabled" {
  type        = "string"
  default     = true
  description = "disabling this will block all the INGRESS traffic on port 1194 of the bastion instances"
}
