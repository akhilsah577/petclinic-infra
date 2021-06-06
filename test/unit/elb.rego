package main

deny[msg] {
  not input.resource.aws_elb.web_elb
  msg = "Web ELB not declared"
}

deny[msg] {
  not input.resource.aws_elb.mgmt_elb
  msg = "Management ELB not declared"
}

deny[msg] {
  not input.resource.aws_elb.web_elb.health_check
  msg = "Web ELB healthcheck not defined"
}

deny[msg] {
  not input.resource.aws_elb.web_elb.listener
  msg = "Web ELB listener not defined"
}

deny[msg] {
  not input.resource.aws_elb.mgmt_elb.health_check
  msg = "Management ELB healthcheck not defined"
}

deny[msg] {
  not input.resource.aws_elb.mgmt_elb.listener
  msg = "Management ELB listener not defined"
}

deny[msg] {
  not re_match(".*private", input.resource.aws_elb.web_elb.subnets[0])
  msg = "Private Subnets not assigned to Web ELB"
}

deny[msg] {
  not re_match(".*public", input.resource.aws_elb.mgmt_elb.subnets[0])
  msg = "Public Subnets not assigned to Web ELB"
}

deny[msg] {
  not input.resource.aws_elb.web_elb.instances
  msg = "Instances not attached"
}

deny[msg] {
  not input.resource.aws_elb.mgmt_elb.instances
  msg = "Instances not attched"
}
