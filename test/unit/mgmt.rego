package main

deny[msg] {
  not input.resource.aws_instance.mgmt
  msg = "Management EC2 machine not declared"
}

deny[msg] {
  not input.data.aws_ami.mgmt
  msg = "AMI data not being interpolated"
}


