resource "google_container_cluster" "main" {
  name     = "${var.name}-${var.env}"
  location = "${var.region}"

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "${var.subnetwork_master_cidr}"
  }

  ip_allocation_policy {
    use_ip_aliases                = true
    cluster_secondary_range_name  = "cluster-cidr"
    services_secondary_range_name = "services-cidr"
  }

  min_master_version = "${var.kube_master_version}"
  network            = "${google_compute_network.main.self_link}"
  subnetwork         = "${google_compute_subnetwork.main.self_link}"
  logging_service    = "logging.googleapis.com"

  maintenance_policy {
    daily_maintenance_window {
      start_time = "${var.daily_maintenance_time}"
    }
  }

  master_authorized_networks_config {
    cidr_blocks = "${var.master_authorized_cidr_blocks}"
  }

  network_policy {
    enabled  = true
    provider = "CALICO"
  }

  addons_config {
    http_load_balancing {
      disabled = true
    }

    horizontal_pod_autoscaling {
      disabled = false
    }

    network_policy_config {
      disabled = false
    }
  }

  remove_default_node_pool = true
  initial_node_count       = 1

  timeouts {
    update = "20m"
  }
}

resource "google_container_node_pool" "pool" {
  provider = "google-beta"
  count    = "${length(var.node_pools)}"
  name     = "${lookup(var.node_pools[count.index], "name")}"
  location = "${google_container_cluster.main.location}"
  cluster  = "${google_container_cluster.main.name}"

  autoscaling {
    min_node_count = "${lookup(var.node_pools[count.index], "autoscaling_min_node_count", 1)}"
    max_node_count = "${lookup(var.node_pools[count.index], "autoscaling_max_node_count", 1)}"
  }

  initial_node_count = "${lookup(var.node_pools[count.index], "initial_node_count", 1)}"

  management {
    auto_repair  = "${lookup(var.node_pools[count.index], "auto_repair", true)}"
    auto_upgrade = "${lookup(var.node_pools[count.index], "auto_upgrade", false)}"
  }

  node_config {
    disk_size_gb = "${lookup(var.node_pools[count.index], "disk_size_gb", 100)}"
    disk_type    = "${lookup(var.node_pools[count.index], "disk_type", "pd-ssd")}"
    image_type   = "${lookup(var.node_pools[count.index], "os", "COS")}"
    machine_type = "${lookup(var.node_pools[count.index], "machine_type", "n1-standard-1")}"
    preemptible  = "${lookup(var.node_pools[count.index], "preemptible", false)}"

    labels {
      name = "${var.name}"
      env  = "${var.env}"
    }

    metadata {
      block-project-ssh-keys   = "true"
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    taint = "${var.node_taints[lookup(var.node_pools[count.index], "name")]}"

    tags = [
      "${var.name}",
      "${var.env}",
      "internal-${var.env}",
    ]
  }

  version = "${var.kube_node_version}"

  timeouts {
    update = "20m"
  }
}
