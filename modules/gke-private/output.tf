output "heketi-topology" {
  value = "${local.heketi-topology}"
}

output "kubeconfig" {
  value = "${local.cluster-kubeconfig}"
}

output "internal_ips" {
  value = "${flatten(google_compute_instance.data-server-instance.*.network_interface.0.address)}"
}

locals {
  heketi-topology = <<EOF
{
    "clusters": [
        {
            "nodes": [
                {
                    "node": {
                        "hostnames": {
                            "manage": [
                                "${element(google_compute_instance.data-server-instance.*.name, 0)}"
                            ],
                            "storage": [
                                "${element(google_compute_instance.data-server-instance.*.network_interface.0.address, 0)}"
                            ]
                        },
                        "zone": 1
                    },
                    "devices": [
                        "/dev/sdb"
                    ]
                },
                {
                    "node": {
                        "hostnames": {
                            "manage": [
                                "${element(google_compute_instance.data-server-instance.*.name, 1)}"
                            ],
                            "storage": [
                                "${element(google_compute_instance.data-server-instance.*.network_interface.0.address, 1)}"
                            ]
                        },
                        "zone": 1
                    },
                    "devices": [
                        "/dev/sdb"
                    ]
                },
                {
                    "node": {
                        "hostnames": {
                            "manage": [
                                "${element(google_compute_instance.data-server-instance.*.name, 2)}"
                            ],
                            "storage": [
                                "${element(google_compute_instance.data-server-instance.*.network_interface.0.address, 2)}"
                            ]
                        },
                        "zone": 1
                    },
                    "devices": [
                        "/dev/sdb"
                    ]
                }
            ]
        }
    ]
}
EOF

  cluster-kubeconfig = <<EOF
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${google_container_cluster.cluster.master_auth.0.cluster_ca_certificate}
    server: https://${google_container_cluster.cluster.endpoint}
  name: ${var.name}-${var.env}
contexts:
- context:
    cluster: ${var.name}-${var.env}
    namespace: default
    user: ${var.name}-${var.env}-admin
  name: admin@${var.name}-${var.env}
current-context: admin@${var.name}-${var.env}
kind: Config
preferences: {}
users:
- name: ${var.name}-${var.env}-admin
  user:
    username: ${google_container_cluster.cluster.master_auth.0.username}
    password: ${google_container_cluster.cluster.master_auth.0.password}
EOF
}
