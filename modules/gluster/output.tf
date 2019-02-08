// output "heketi-topology" {
//   value = "${local.heketi-topology}"
// }

// heketi-topology = <<EOF  // {  //     "clusters": [  //         {  //             "nodes": [  //                 {  //                     "node": {  //                         "hostnames": {  //                             "manage": [  //                                 "${element(google_compute_instance.data-server-instance.*.name, 0)}"  //                             ],  //                             "storage": [  //                                 "${element(google_compute_instance.data-server-instance.*.network_interface.0.address, 0)}"  //                             ]  //                         },  //                         "zone": 1  //                     },  //                     "devices": [  //                         "/dev/sdb"  //                     ]  //                 },  //                 {  //                     "node": {  //                         "hostnames": {  //                             "manage": [  //                                 "${element(google_compute_instance.data-server-instance.*.name, 1)}"  //                             ],  //                             "storage": [  //                                 "${element(google_compute_instance.data-server-instance.*.network_interface.0.address, 1)}"  //                             ]  //                         },  //                         "zone": 1  //                     },  //                     "devices": [  //                         "/dev/sdb"  //                     ]  //                 },  //                 {  //                     "node": {  //                         "hostnames": {  //                             "manage": [  //                                 "${element(google_compute_instance.data-server-instance.*.name, 2)}"  //                             ],  //                             "storage": [  //                                 "${element(google_compute_instance.data-server-instance.*.network_interface.0.address, 2)}"  //                             ]  //                         },  //                         "zone": 1  //                     },  //                     "devices": [  //                         "/dev/sdb"  //                     ]  //                 }  //             ]  //         }  //     ]  // }  // EOF

output "internal_ips" {
  value = "${flatten(google_compute_instance.data-server-instance.*.network_interface.0.address)}"
}
