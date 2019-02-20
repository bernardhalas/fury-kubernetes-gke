variable "name" {}

variable "region" {
  default = "europe-west1"
}

variable "env" {}

variable "databases" {
  type    = "list"
  default = []
}

variable "database-version" {
  default = "POSTGRES_9_6"
}

variable "instance-type" {
  default = "custom-1-4096"
}

provider "google" {
  version = "2.0.0"
}

// variable "network" {
//   type        = "string"
//   description = "network link to connect the instance to"
// }

// provider "google-beta" {
//   version = "2.0.0"
// }
