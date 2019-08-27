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
