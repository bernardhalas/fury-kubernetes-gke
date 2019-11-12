# Fury Kubernetes GKE

This repo contains all components necessary to deploy a GKE private, regional cluster on GoogleCloudPlatform

## Requirements

All packages in this repository have following dependencies, for package
specific dependencies please visit the single package's documentation:

- GCP ServiceAccount with Project Editor permissions
- [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) >= `v0.11.11`
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) >= `v1.11.7`

## Compatibility

| Distribution Version / Kubernetes Version | 1.11.X             | 1.12.X             | 1.13.X             | 1.14.X             | 1.15.X             | 1.16.X             |
|-------------------------------------------|:------------------:|:------------------:|:------------------:|:------------------:|:------------------:|:------------------:|
| v1.11.6                                   | :white_check_mark: |                    |                    |                    |                    |                    |

- :white_check_mark: Compatible
- :warning: Has issues
- :x: Incompatible

## Examples

To see examples on how to customize Fury distribution with kustomize please go to [examples](examples)

##  GKE modules

- [gke-private](modules/gke-private): Production ready GKE cluster with private instances and NAT gateway

You can click on each package to see its documentation.

## License

For license details please see [LICENSE](https://sighup.io/fury/license)
