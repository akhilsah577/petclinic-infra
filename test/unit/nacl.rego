package main

deny[msg] {
  not input.resource.aws_network_acl_rule.public_nacl_ingress
  msg = "Ingress NACL not defined"
}

deny[msg] {
  not input.resource.aws_network_acl_rule.public_nacl_egress
  msg = "Public NACL egress rule not defined"
}

