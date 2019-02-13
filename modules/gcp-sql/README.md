# GCP SQL

Creates a private regional HA managed SQL server

```hcl
module "staging-sql" {
  source = "../vendor/modules/gke/gcp-sql"
  name = "customer-name"
  env = "staging"
  region = "europe-west1"
  network = "${google_compute_network.private_network.self_link}"
  databases = ["database1", "database2-users"]
  instance-type = "custom-1-4096"
}
```