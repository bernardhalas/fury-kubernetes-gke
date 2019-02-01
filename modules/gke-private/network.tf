resource "google_compute_subnetwork" "cluster" {
  name                     = "${var.region}-${var.name}-${var.env}"
  ip_cidr_range            = "${var.subnetwork_node_cidr}"
  network                  = "${var.network}"
  region                   = "${var.region}"
  private_ip_google_access = true

  secondary_ip_range = [{
    range_name    = "services-cidr"
    ip_cidr_range = "${var.subnetwork_svc_cidr}"
  },
    {
      range_name    = "cluster-cidr"
      ip_cidr_range = "${var.subnetwork_pod_cidr}"
    },
  ]
}

// THIS IS NEEDED TO ALLOW PODS AND SERVICES TO ACCESS THE INTERNET
resource "google_compute_firewall" "pod-svc-to-proxy" {
  name      = "${var.name}-${var.env}-squid-from-k8s"
  network   = "${var.network}"
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["3128"]
  }

  target_tags   = ["proxy-${var.env}"]
  source_ranges = ["${var.subnetwork_pod_cidr}", "${var.subnetwork_svc_cidr}"]
}

// THIS IS NEEDED TO ALLOW OPERATORS TO ACCESS THE INTERNALS OF THE CLUSTER
resource "google_compute_firewall" "ssh" {
  name      = "${var.name}-${var.env}-ssh"
  network   = "${var.network}"
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["proxy-${var.env}"]
  source_ranges = ["0.0.0.0/0"]
}

// THIS IS NEEDED TO ALLOW NODES IN THE SAME SUBNET TO COMUNICATE TO EACH OTHER
resource "google_compute_firewall" "nodes" {
  name      = "${var.name}-${var.env}-nodes"
  network   = "${var.network}"
  direction = "INGRESS"

  allow {
    protocol = "all"
  }

  target_tags = ["${var.env}"]
  source_tags = ["${var.env}"]
}

// THIS IS NEEDED TO ALLOW PODS AND SERVICES TO ACCESS NODES
resource "google_compute_firewall" "pods-to-gluster" {
  name      = "${var.name}-${var.env}-pod-to-nodes"
  network   = "${var.network}"
  direction = "INGRESS"

  allow {
    protocol = "all"
  }

  target_tags   = ["${var.env}"]
  source_ranges = ["${var.subnetwork_pod_cidr}", "${var.subnetwork_svc_cidr}"]
}
