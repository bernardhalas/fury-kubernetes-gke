resource "google_compute_address" "bastion" {
  name   = "bastion-${var.name}-${var.env}"
  region = "${var.region}"
}

resource "google_compute_instance" "bastion" {
  count                     = "${var.bastion-count}"
  name                      = "bastion-${var.name}-${var.env}-${count.index+1}"
  machine_type              = "${var.bastion-machine-type}"
  tags                      = ["bastion-${var.env}", "${var.name}", "${var.env}", "vpn"]
  can_ip_forward            = true
  zone                      = "${data.google_compute_zones.available.names[count.index]}"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.bastion.self_link}"
    }
  }

  service_account {
    scopes = ["cloud-platform"]
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.main.self_link}"

    access_config {
      nat_ip = "${google_compute_address.bastion.address}"
    }
  }

  scheduling {
    on_host_maintenance = "MIGRATE"
    automatic_restart   = true
  }

  metadata {
    env                    = "${var.env}"
    role                   = "vpn"
    block-project-ssh-keys = true
  }

  lifecycle {
    ignore_changes = ["boot_disk.0.initialize_params.0.image"]
  }
}

resource "google_compute_firewall" "ssh" {
  count     = "${var.bastion-ssh-enabled}"
  name      = "${var.name}-${var.env}-ssh-tcp"
  network   = "${google_compute_network.main.self_link}"
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["bastion-${var.env}"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "vpn" {
  count     = "${var.bastion-vpn-enabled}"
  name      = "${var.name}-${var.env}-ssh-udp"
  network   = "${google_compute_network.main.self_link}"
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["1194"]
  }

  allow {
    protocol = "udp"
    ports    = ["1194"]
  }

  target_tags   = ["bastion-${var.env}"]
  source_ranges = ["0.0.0.0/0"]
}
