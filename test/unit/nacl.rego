package main

deny[msg] {
  not input.resource.aws_network_acl.public_subnet
  msg = "Public NACL not defined"
}

deny[msg] {
  not input.resource.aws_network_acl.private_subnet
  msg = "Private NACL not defined"
}

deny[msg] {
  not input.resource.aws_network_acl_rule.private_nacl_ingress_http
  msg = "Private NACL http ingress rule not defined"
}

deny[msg] {
  not input.resource.aws_network_acl_rule.private_nacl_egress_all
  msg = "Private NACL outbound rule for all not defined"
}

deny[msg] {
  not input.resource.aws_network_acl_rule.public_nacl_ingress_http
  msg = "Public NACL http ingress rule not defined"
}

deny[msg] {
  not input.resource.aws_network_acl_rule.public_nacl_egress_all
  msg = "Public NACL outbound rule for all not defined"
}

deny[msg] {
  not re_match("0.0.0.0/0", input.resource.aws_network_acl_rule.public_nacl_ingress_http.cidr_block)
  msg = "Public NACL rule from internet not defined"
}

deny[msg] {
  not re_match("0.0.0.0/0", input.resource.aws_network_acl_rule.public_nacl_egress_all.cidr_block)
  msg = "Public NACL outbound rule for all not defined"
}
