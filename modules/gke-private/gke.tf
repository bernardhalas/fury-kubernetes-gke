resource "google_container_cluster" "cluster" {
  name        = "${var.name}-${var.env}"
  description = "internal cluster ${var.region}-${var.name}-${var.env}"
  region      = "${var.region}"

  // PRIVATE CLUSTER CONFIGURATIONS
  master_ipv4_cidr_block = "${var.master_cidr}"
  private_cluster        = true

  ip_allocation_policy {
    cluster_secondary_range_name  = "cluster-cidr"
    services_secondary_range_name = "services-cidr"
  }

  // ---------------------------------------
  min_master_version = "${var.kube-master-version}"
  network            = "${var.network}"
  subnetwork         = "${google_compute_subnetwork.cluster.self_link}"

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "${var.authorized_cidr}"
      display_name = "default"
    }
  }

  node_pool {
    name       = "first-pool-${var.name}-${var.env}"
    node_count = "${var.node-number}"

    management {
      auto_repair  = "false"
      auto_upgrade = "false"
    }

    version = "${var.kube-node-version}"

    node_config {
      disk_size_gb = 80
      disk_type    = "pd-ssd"
      machine_type = "${var.node-type}"

      // image_type = "COS"
      image_type  = "UBUNTU"
      preemptible = "${var.preemptible}"

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
        env     = "${var.env}"
        role    = "gke"
        sshKeys = "root:${file("${var.ssh_public_key}")}"
      }

      tags = ["${var.name}", "${var.env}", "internal-${var.env}"]
    }

    timeouts {
      update = "20m"
    }
  }

  addons_config {
    http_load_balancing {
      disabled = true
    }

    horizontal_pod_autoscaling {
      disabled = true
    }
  }

  network_policy {
    enabled = true
  }
}
