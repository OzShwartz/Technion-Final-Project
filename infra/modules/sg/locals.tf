locals {
  ingress_ports = concat(var.default_ports, var.extra_ports)
}
