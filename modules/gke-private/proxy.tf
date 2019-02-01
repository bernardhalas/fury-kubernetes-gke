// https://www.terraform.io/docs/providers/google/r/compute_instance.html
resource "google_compute_instance" "nat-gateway" {
  count          = "${var.proxy_count}"
  name           = "squid-proxy-${var.name}-${var.env}-${count.index+1}"
  machine_type   = "${var.proxy_machine_type}"
  tags           = ["proxy-${var.env}", "${var.name}", "${var.env}", "nat"]
  can_ip_forward = true
  zone           = "${data.google_compute_zones.available.names[count.index]}"

  boot_disk {
    initialize_params {
      image = "${var.proxy_image}"
    }
  }

  network_interface {
    subnetwork    = "${google_compute_subnetwork.cluster.self_link}"
    access_config = {}
  }

  scheduling {
    automatic_restart = "${var.preemptible == false ? true : false }"
    preemptible       = "${var.preemptible}"
  }

  metadata {
    env  = "${var.env}"
    role = "nat"
  }
}

resource "google_compute_route" "internet" {
  count                  = "${var.proxy_count}"
  name                   = "internet-route-${var.env}-${count.index}"
  dest_range             = "0.0.0.0/0"
  network                = "${var.network}"
  priority               = 1000
  next_hop_instance      = "${element(google_compute_instance.nat-gateway.*.self_link, count.index)}"
  next_hop_instance_zone = "${element(google_compute_instance.nat-gateway.*.zone, count.index)}"
  tags                   = ["internal-${var.env}"]
  depends_on             = ["google_container_cluster.cluster"]
}
