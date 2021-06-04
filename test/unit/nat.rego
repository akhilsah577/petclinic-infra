package main

deny[msg] {
  not input.resource.aws_nat_gateway.nat_gateway
  msg = "NAT Gateway not declared"
}

deny[msg] {
  not input.resource.aws_route_table.nat_gateway_rt
  msg = "Route Table not declared"
}

deny[msg] {
  not input.resource.aws_route_table_association.nat_gateway_rt_association
  msg = "Route table association not declared"
}

deny[msg] {
  not input.resource.aws_security_group.nat_sg
  msg = "Security Group for NAT Gateway not declared"
}
