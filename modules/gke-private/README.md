# GKE private

For security reasons all the hosts in the cluster will take the ssh keys added to the GCP project. 
For now, there is not an automatic way of adding all your users's key, but it's easy to manage by hand.

This is the console url for changing/adding/removing keys https://console.cloud.google.com/compute/metadata/sshKeys

Google keeps these keys sincronized with the ones in the hosts, this means that removing a key effectively removes access to the host without recreating/destroying/rebooting it.

By default these keys must be added:
```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDhdDofxCxV/RRSGJAPjBGjIIj0kN6iJH7TddtHyqiHASU4XEqg6j9Q99OVNesMCF0xDDX3jy5PMsbByx3nLP7N/V1tg/d33Cb7//uGTeK59dPqr6ldrDNM4JpFtj74BM1o7cqUVPQFL22X9HwgYTvzHl5m0VKRPpfU4no3XVEmL2oj0YE3r4oEWHQI2ekSxznUt6Oz/Q7QPD1Z9pXhBpGvqkUBKEXbdbb4IlTG04Oz19XqU18tDv1Keo0uR/oTB+ZsQytIe3VeuK+Fw6tD6RnBaOCivcYaDTreb8vT3Gc+lxNPsXJC6722jX37UwdGEOjB7muEQ8BITWWSmMyAoJcWUR2jsymxnBf7vbFTmGpOmB8fGHmRsu7k/HFH/sv/XXTAGh68tlOHDi5I6f2iESwxOUFnXynqJ/nuFJfh89v/MfZ5W6ftX8Jf1uyi4Jadx7TSCeYcj3cyfIPorwN1j8iurS/Wbw3Dnseoo4RO0C5JSepygUTLpJWmZFb+ylkjqvdJztUuPZdvwRPPCectUWmcUJLDg2Y+ZUcjBFoJ+HPRInGkzO8FkaiMEhYWZGnq4ho2zG8nhRf6FqzY3JxUWJ091KwCps4ckebphBbOawpiCKHB0J6Rg3fKbATg3wOuIt2N+Dvts0Zr5gbCdf4KxlGL6UaeVJW9D864yQCHg5REJw== giacomo@sighup.io
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC0sczrB2dWdE4GLJhcWUEEnL3JLMCorn4QcJaLHC7luLiuNdx8uqUqR5Dy3VVd7DP4aLlRIaUXbnVEiUcgOxdZ2CJZO7rnj9xGaq+ocpyH6+l+f9Q81NYXNJs/k5Xr4i21TeXqT6T7XgOTBJQKN6a1whe48gPuTBT4F46MPAqLUZDtzyvEZCNg43FuQSHUkey9bN1ayNkMT2IDEs5Xpc9SF3XdOwDatQf86jBx3tIeQtybRfgLYUycyEK3qxu1a73DPRmyp14MhDkZiGCNhURPAjs+WDkl+3ICgKcl742/fYimoKipxVkBdG91/pnrSilKB5BDpGMY7CURV4nlUr1qdIHVCOMXzd/jTVxxYA0EuBZGfq39O8Ox/O0CUf/emo/lyB5ysjCYafcnRevPlNDCaPyxNcDGYebowkpuLZvbJSO3aQzUStT4fDLSvd2E+Z1YYh0Fu1sP6JR5/Vrw5PyEeo2iNxONbm6bQFdKe9sWPTslwdMOUMUoV6vmLhSwUdxi+SNo+Z5f7hL5B8gCxyl9O5X+KVB8P9f3AfPjO6nYs2s8tFlzYTq54XGcRYvdCH1JQu5ZyMhr385IHFL3DrYWx7lnEpOTbOgATELxjNYyHUMfj2/kgVvSuuZNr8p9yTDVtnvcndaGaYPz8YK6E+5B2Yhxh+Ts2VdMUG2EDB4nLQ== luca@sighup.io
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDRNqBgGxrcUVXkUNmuzGn+ojlilebn25uTL4cpgxBdknqwykhRAFD3eparmsRGQT0qhi6Z4EXGIEVJkls+9dluRChJRWNnivcq3d/mUkwbRSekTd+5PWVfnl4l4rZaVTO3v6t2sE+VNaB8IZ5Gl15fbsLcCro2ibIT/W2+WsZ+usBVOqwFF0gezUIzc1Umbgu6i6iDnjcrk9k7XQGFCeHy7s9WguMx6Tyi2no+PUw4cCJNIq6hC21GddpleriKEuTkWC7npk8JCv0L0Z9orpMfCWW0hfsVnPDMOsitR2WpxB5/U+io8SwdTxxROtiaf6tfCYCNoE1pYK2z3u8zQysSdpN5edbI3UP3HkhZD8OgAN57iz4KUDN8e67XL2F2HfFeW4DWsSUDfonpmm1kKU3ucHa8pYYOSq+2tMlcJKwKStC7oHrTpv4yWSA0SjkPJ0rzTaO6InuYfLvJ51SptR1mYc2L9CVEYLSea9z3sNc4M2TD4OfHRHlQMU1uYam1krRO0dXtssHkIpAH5RG81bDYHOx1BANBDeiy504Tk5aEPwuxZNS5QjADLqr5GDGFgU4kszfLyCL1cpH0kL9GAjqZzZTN7nw5x+MeO5fyFE9CLPoTqcOzer+WnXlcPwddl6OtsamNq5TAeufxOHDslPrj14/xuRei07en+7qS7fZtEQ== berat@sighup.io
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDWt6+Xs4vjAItAViEEQlp1mNStRwK+eRtsf3CGjJOVj+rvcUJQZ2sFdZS/e1pDx8RykF8Sf9/tmGJZrAGrckLnZ4Q8TawGeiuisf2RPpIDT+3m5I1rpz8ulEt9ITeDZCrnTwV0A7nX23DlMT1O1ky6IFqju7MgwPJ6PRB2gzCykSs2B5QbBcEQ20JwqW5xivy+1PhV8uNb2BxB3qzRAKdg5ji01dle1flSBnv4RkoEG9hEeHRbtG81WXbKn/Ngsz9mGnDB1ItfYRWE46jEUcnqG5YZl1d7iY9i5IDqmN9mYH4oENyLMLKnNu5R/KmJmeHRt0xubCjnAD8xfIRtwWVkNAbP9E6YOqCEbI2uErgEHB/L3pR/NIjMAjIGPb/vzO8/nnfe01Y/w7tiNGdiRDMXQ+zK6LQLmJ14hrUHx/08lrygxjyHPYCSt8p357vE78iUIR+WLalbXCA0UBNiNQX4uPpS4sQwWAckcExvxpFnoIA9sGr2UT7mUq2u7GQbuYLtD7Ctdqftd4X2wRoAxDy2kmugHW/ryW/ujggTYjqS67mqXLVx3ocqICds86PlGL90J+wVLP6tB+Uyy5XfsFlN0Ub9ogsBytQCv1NxaVXZgjZD2c8M9Ku9SF2NH8nKObmr+EuXcwjgw385FnMDu95qfcOwIEuCl3I2TFcj8QGuQw== jacopo@sighup.io
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+T7+hC3CWWuZCwZcbkryTwu18EQnGA/z0IVDlcVr/wR5RD7WoyYip7sFoxIKWecBTxgZABBNkLKu2NH6VGeQ0VO3kF/eD32Cw8Og9sf9LXHmkHVrIevZinYvVVqN9PjFzhJ24YeKNIDmR/9xrscNdOLsF4f9AsvErAu+KCXBpIfhizXWOxvRzdYE7pv30nqisAwwxa5LzzyA5yS8LxLNeuzdN7iNSdzeN7SCYyNK5OMLoFN5x/WPYCor+zm07O88BpZm3hGpqv3N15/Yx8LIZ70QNFvMFYSZ62g9Hqgt2U6wDRgITRipozoi0Gwl7IEOyc/gh7SCwNVdupxImPhjpzApVr7zhXPL5sTcEwhFE4JRZhJgiO610pFqUrH+neeEY9ei6WmY8NPLscvttSMDE4048vEUTDxgzRPCKq8cf/b2gAjEgitWpNIQetjSeN6oFILPQ1PrqJrm/Fxa/Rk5JxO18YL9bFjYDAqNXncnAazV3YqAgg5PycTYwgs6piL3vRObBJsQ0nvv9e6USlvxfS9M4d1YAoiej1HqkQrV6MkEMT19SoU1GfNSz/+tIvpQDURDi684e+xWSacCoh/LY0LtlzwUBrnGTfjvXyM3udo48vFQaDZPVo2RZsiGlbx9VMJxR1rC9w0hYtfATBZLRwI7Wj7cdS7Pie0zMRkvHjw== philippe@sighup.io
```


# Usage
main.tf
```hcl
terraform {
  backend "gcs" {
    bucket  = "customer-terraform"
    prefix  = "sighup"
  }
  required_version = ">= 0.11.11"
}

provider "google" {
  version = "1.20.0"
}

module "staging" {
  source = "../vendor/modules/gke/gke-private"
  name = "example-customer"
  env = "staging"
  region = "europe-west1"
  subnetwork-master-cidr = "10.20.0.96/28"
  master-authorized-cidr = "0.0.0.0/0"
  kube-master-version = "1.11.6-gke.6"
  kube-node-version = "1.11.6-gke.6"
  node-number = 1
  node-type = "n1-standard-2"
  node-os = "COS"
  infra-node-number = 0
  subnetwork-node-cidr = "10.1.0.0/16"
  subnetwork-pod-cidr = "10.3.0.0/16"
  subnetwork-svc-cidr = "10.5.0.0/16"
  bastion-ssh-enabled = true
  bastion-vpn-enabled = true
}

module "production" {
  source = "../vendor/modules/gke/gke-private"
  name = "example-customer"
  env = "production"
  region = "europe-west1"
  subnetwork-master-cidr = "10.20.1.96/28"
  master-authorized-cidr = "0.0.0.0/0"
  kube-master-version = "1.11.6-gke.6"
  kube-node-version = "1.11.6-gke.6"
  node-number = 2
  node-os = "COS"
  node-type = "n1-standard-2"
  infra-node-number = 1
  subnetwork-node-cidr = "10.101.0.0/16"
  subnetwork-pod-cidr = "10.103.0.0/16"
  subnetwork-svc-cidr = "10.105.0.0/16"
  bastion-ssh-enabled = true
  bastion-vpn-enabled = true
}
```