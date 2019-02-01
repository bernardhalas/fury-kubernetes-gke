# GKE private

```hcl
module "cluster-staging" {
  source = "./complete-cluster"
  name = "${var.name}"
  env = "staging"
  region = "${var.region}"
  master_cidr = "10.20.0.96/28"
  kube-master-version = "1.10.7-gke.2"
  kube-node-version = "1.10.7-gke.2"
  node-number = 1
  node-type = "n1-standard-2"
  preemptible = "false" 
  authorized_cidr = "${var.authorized_cidr}"
  network = "${google_compute_network.multienv.self_link}"
  subnetwork_node_cidr = "10.0.0.0/16"
  subnetwork_pod_cidr = "10.3.0.0/16"
  subnetwork_svc_cidr = "10.10.0.0/16"
  proxy_count = 2
  proxy_machine_type = "g1-small"
  proxy_image = "${var.proxy_image}"
  glusterd_count = 3
  glusterd_disk_dimension = "300"
  glusterd_machine_type = "n1-standard-1"
  glusterd_ip_offset = 1024
  glusterd_image = "${var.glusterd_image}"
  glusterd_public_key = "staging.pub"
}
```