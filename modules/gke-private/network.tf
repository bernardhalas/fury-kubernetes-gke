resource "google_compute_network" "main" {
  name                    = "${var.name}-${var.env}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "main" {
  name                     = "${var.region}-${var.name}-${var.env}"
  ip_cidr_range            = "${var.subnetwork-node-cidr}"
  network                  = "${google_compute_network.main.self_link}"
  region                   = "${var.region}"
  private_ip_google_access = true

  secondary_ip_range = [
    {
      range_name    = "services-cidr"
      ip_cidr_range = "${var.subnetwork-svc-cidr}"
    },
    {
      range_name    = "cluster-cidr"
      ip_cidr_range = "${var.subnetwork-pod-cidr}"
    },
  ]
}

resource "google_compute_address" "main" {
  count  = 2
  name   = "nat-ip-${var.name}-${var.env}-${count.index}"
  region = "${var.region}"
}

resource "google_compute_router" "main" {
  name    = "router-${var.name}-${var.env}"
  region  = "${var.region}"
  network = "${google_compute_network.main.self_link}"
}

resource "google_compute_router_nat" "main" {
  name                               = "nat-${var.name}-${var.env}"
  router                             = "${google_compute_router.main.name}"
  region                             = "${var.region}"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = ["${google_compute_address.main.*.self_link}"]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

// THIS IS NEEDED TO ALLOW NODES IN THE SAME SUBNET TO COMUNICATE TO EACH OTHER
resource "google_compute_firewall" "nodes" {
  name      = "${var.name}-${var.env}-nodes"
  network   = "${google_compute_network.main.self_link}"
  direction = "INGRESS"

  allow {
    protocol = "all"
  }

  target_tags = ["${var.env}"]
  source_tags = ["${var.env}"]
}
