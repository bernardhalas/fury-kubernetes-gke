output "kubeconfig" {
  value = "${local.cluster-kubeconfig}"
}

output "bastion-external-ip" {
  value = "${google_compute_address.bastion.address}"
}

output "network" {
  value = "${google_compute_network.main.self_link}"
}

output "cluster" {
  value = "${google_container_cluster.main.name}"
}

output "subnetwork" {
  value = "${google_compute_subnetwork.main.self_link}"
}

locals {
  cluster-kubeconfig = <<EOF
apiVersion: v1
kind: Config
clusters:
- cluster:
    certificate-authority-data: ${google_container_cluster.main.master_auth.0.cluster_ca_certificate}
    server: https://${google_container_cluster.main.endpoint}
  name: ${var.name}-${var.env}
contexts:
- context:
    cluster: ${var.name}-${var.env}
    namespace: default
    user: ${var.name}-${var.env}-admin
  name: admin@${var.name}-${var.env}
current-context: admin@${var.name}-${var.env}
preferences: {}
users:
- name: ${var.name}-${var.env}-admin
  user:
    username: ${google_container_cluster.main.master_auth.0.username}
    password: ${google_container_cluster.main.master_auth.0.password}
EOF
}
