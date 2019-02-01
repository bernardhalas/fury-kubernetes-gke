resource "google_compute_disk" "data-server-disk" {
  count = "${var.glusterd_count}"
  name  = "glusterd-volume-${var.name}-${var.env}-${count.index}"
  type  = "pd-ssd"
  zone  = "${data.google_compute_zones.available.names[count.index]}"
  size  = "${var.glusterd_disk_dimension}"
}

resource "google_compute_instance" "data-server-instance" {
  count          = "${var.glusterd_count}"
  name           = "glusterd-${var.name}-${var.env}-${count.index}"
  machine_type   = "${var.glusterd_machine_type}"
  zone           = "${data.google_compute_zones.available.names[count.index]}"
  can_ip_forward = true

  boot_disk {
    initialize_params {
      image = "${var.glusterd_image}"
      type  = "pd-ssd"
      size  = 30
    }
  }

  attached_disk {
    source = "${element(google_compute_disk.data-server-disk.*.name, count.index)}"
    mode   = "READ_WRITE"
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.cluster.self_link}"
    address    = "${cidrhost(google_compute_subnetwork.cluster.ip_cidr_range, count.index+var.glusterd_ip_offset)}"
  }

  tags = ["glusterd", "${var.env}", "internal-${var.env}"]

  metadata {
    env     = "${var.env}"
    role    = "glusterd"
    sshKeys = "root:${file("${var.ssh_public_key}")}"
  }
}
