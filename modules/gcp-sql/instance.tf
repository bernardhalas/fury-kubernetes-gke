resource "google_sql_database_instance" "main" {
  name             = "sql-${var.name}-${var.env}"
  region           = "${var.region}"
  database_version = "${var.database-version}"

  settings {
    tier              = "${var.instance-type}"
    activation_policy = "ALWAYS"
    availability_type = "REGIONAL"
    disk_autoresize   = true
    disk_size         = 10                     # this is initial disk size
    disk_type         = "PD_SSD"

    maintenance_window {
      day          = 3
      hour         = 5
      update_track = "stable"
    }

    backup_configuration {
      enabled    = true
      start_time = "00:45"
    }

    ip_configuration {
      ipv4_enabled    = "false"
      private_network = "${var.network}"
    }
  }
}

resource "google_sql_database" "main" {
  count     = "${length(var.databases)}"
  name      = "${element(var.databases,count.index)}"
  instance  = "${google_sql_database_instance.main.name}"
  charset   = "UTF8"
  collation = "en_US.UTF8"
}

resource "google_compute_global_address" "main" {
  provider      = "google-beta"
  name          = "sql-ip-${var.name}-${var.env}"
  address_type  = "INTERNAL"
  purpose       = "VPC_PEERING"
  prefix_length = 16
  network       = "${var.network}"
}

resource "google_service_networking_connection" "main" {
  provider                = "google-beta"
  network                 = "${var.network}"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = ["${google_compute_global_address.main.name}"]
}
