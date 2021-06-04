package main

deny[msg] {
  not input.resource.aws_instance.web
  msg = "Web EC2 machine not declared"
}

deny[msg] {
  not input.resource.aws_elb.web_elb
  msg = "Load Balncer for Web machine not declared"
}

deny[msg] {
  not input.resource.aws_security_group.web_sg
  msg = "Web EC2 machine security group not declared"
}

deny[msg] {
  not input.data.aws_ami.web
  msg = "AMI data not being interpolated"
}


