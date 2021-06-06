package main

deny[msg] {
  not input.resource.aws_security_group.nat_sg
  msg = "NAT Security group not defined"
}

deny[msg] {
  not input.resource.aws_security_group.web_sg
  msg = "Web Security group not defined"
}

deny[msg] {
  not input.resource.aws_security_group.web_elb_sg
  msg = "Web ELB Security group not defined"
}

deny[msg] {
  not input.resource.aws_security_group.mgmt_sg
  msg = "Mgmt Security group not defined"
}

deny[msg] {
  not input.resource.aws_security_group.mgmt_elb_sg
  msg = "Mgmt ELB Security group not defined"
}

deny[msg] {
  not input.resource.aws_security_group_rule.web_sg_ingress
  msg = "Web inbound Security group rule not defined"
}

deny[msg] {
  not input.resource.aws_security_group_rule.web_sg_egress
  msg = "Web outbound security group rule not defined"
}

deny[msg] {
  not input.resource.aws_security_group_rule.mgmt_sg_ingress
  msg = "Management inbound Security group rule not defined"
}

deny[msg] {
  not input.resource.aws_security_group_rule.mgmt_sg_egress
  msg = "Management outbound security group rule not defined"
}

deny[msg] {
  not input.resource.aws_security_group_rule.web_elb_sg_ingress
  msg = "Web ELB inbound security group rule not defined"
}

deny[msg] {
  not input.resource.aws_security_group_rule.web_elb_sg_egress_app
  msg = "Web ELB outbound security group rule not defined"
}

deny[msg] {
  not input.resource.aws_security_group_rule.mgmt_elb_sg_ingress
  msg = "Mgmt ELB inbound security group rule not defined"
}

deny[msg] {
  not input.resource.aws_security_group_rule.mgmt_elb_sg_egress_srv
  msg = "Management ELB outbound service security group rule not defined"
}

deny[msg] {
  not input.resource.aws_security_group_rule.mgmt_elb_sg_egress_all
  msg = "Management ELB outbound security group rule not defined"
}

deny[msg] {
  not re_match("-1", input.resource.aws_security_group_rule.mgmt_elb_sg_egress_all.protocol)
  msg = "Management ELB outbound security group protocol not correct"
}

deny[msg] {
  not re_match(input.resource.aws_security_group_rule.mgmt_elb_sg_egress_all.cidr_blocks[0], "0.0.0.0/0")
  msg = "Management ELB outbound security group rule cidr does not contain public cidr"
}

deny[msg] {
  not input.resource.aws_security_group_rule.mgmt_elb_sg_egress_all.type = "egress"
  msg = "Management ELB outbound security group rule type not correct"
}
