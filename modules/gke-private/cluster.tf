resource "google_container_cluster" "main" {
  name   = "${var.name}-${var.env}"
  region = "${var.region}"

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "${var.subnetwork-master-cidr}"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "cluster-cidr"
    services_secondary_range_name = "services-cidr"
  }

  min_master_version = "${var.kube-master-version}"
  network            = "${google_compute_network.main.self_link}"
  subnetwork         = "${google_compute_subnetwork.main.self_link}"
  logging_service    = "logging.googleapis.com"

  maintenance_policy {
    daily_maintenance_window {
      start_time = "08:00"
    }
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "${var.master-authorized-cidr}"
      display_name = "default"
    }
  }

  addons_config {
    http_load_balancing {
      disabled = true
    }

    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  network_policy {
    enabled = true
  }

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "main" {
  name       = "main-${var.name}-${var.env}"
  node_count = "${var.node-number}"
  region     = "${var.region}"
  cluster    = "${google_container_cluster.main.name}"

  management {
    auto_repair  = "true"
    auto_upgrade = "false"
  }

  version = "${var.kube-node-version}"

  node_config {
    disk_size_gb = 100
    disk_type    = "pd-ssd"
    machine_type = "${var.node-type}"

    image_type  = "${var.node-os}"
    preemptible = "false"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels {
      name    = "${var.name}"
      env     = "${var.env}"
      creator = "terraform-sighup-module"
    }

    metadata {
      env                    = "${var.env}"
      role                   = "gke"
      block-project-ssh-keys = true
    }

    tags = ["${var.name}", "${var.env}", "internal-${var.env}"]
  }

  timeouts {
    update = "20m"
  }
}

resource "google_container_node_pool" "infra" {
  name       = "infra-${var.name}-${var.env}"
  node_count = "${var.infra-node-number}"
  region     = "${var.region}"
  cluster    = "${google_container_cluster.main.name}"

  management {
    auto_repair  = "true"
    auto_upgrade = "false"
  }

  version = "${var.kube-node-version}"

  node_config {
    disk_size_gb = 100
    disk_type    = "pd-ssd"
    machine_type = "${var.infra-node-type}"

    image_type  = "${var.infra-node-os}"
    preemptible = "false"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels {
      name                     = "${var.name}"
      env                      = "${var.env}"
      nodepool                 = "infra"
      creator                  = "terraform-sighup-module"
      disable-legacy-endpoints = true
    }

    metadata {
      env                    = "${var.env}"
      role                   = "gke"
      block-project-ssh-keys = true
      disable-legacy-endpoints = "true"
    }

    tags = ["${var.name}", "${var.env}", "infra-${var.env}", "internal-${var.env}"]
  }

  timeouts {
    update = "20m"
  }
}
