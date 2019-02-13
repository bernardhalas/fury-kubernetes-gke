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

    database_flags {
      name  = "${var.name}"
      value = "${var.env}"
    }

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
      private_network = "${var.network}"
    }
  }
}

resource "google_sql_database" "main" {
  count     = "${len(var.databases)}"
  name      = "${element(var.databases,count.index)}"
  instance  = "${google_sql_database_instance.main.name}"
  charset   = "UTF8"
  collation = "en_US.UTF8"
}
