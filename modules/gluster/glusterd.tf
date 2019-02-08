resource "google_compute_disk" "data-server-disk" {
  count = "${var.glusterd-count}"
  name  = "glusterd-volume-${var.name}-${var.env}-${count.index}"
  type  = "pd-ssd"
  zone  = "${data.google_compute_zones.available.names[count.index]}"
  size  = "${var.glusterd-disk-dimension}"
}

resource "google_compute_instance" "data-server-instance" {
  count          = "${var.glusterd-count}"
  name           = "glusterd-${var.name}-${var.env}-${count.index}"
  machine_type   = "${var.glusterd-machine-type}"
  zone           = "${data.google_compute_zones.available.names[count.index]}"
  can_ip_forward = true

  boot_disk {
    initialize_params {
      image = "${var.glusterd-image}"
      type  = "pd-ssd"
      size  = 30
    }
  }

  attached_disk {
    source = "${element(google_compute_disk.data-server-disk.*.name, count.index)}"
    mode   = "READ_WRITE"
  }

  network_interface {
    subnetwork = "${var.subnetwork}"
    address    = "${cidrhost(google_compute_subnetwork.main.ip_cidr_range, count.index+var.glusterd-ip-offset)}"
  }

  tags = ["glusterd", "${var.env}", "internal-${var.env}"]

  metadata {
    env                    = "${var.env}"
    role                   = "glusterd"
    block-project-ssh-keys = true
    sshKeys                = "root:${file("${var.root-ssh-publickey}")}"
  }
}
