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
  not input.resource.aws_route_table.nat_gateway_rt.vpc_id
  msg = "Route table VPC not assigned"
}

deny[msg] {
  not re_match("0.0.0.0/0", input.resource.aws_route_table.nat_gatway_rt.route.cidr_block)
  msg = "Route table public CIDR assigned"
}

deny[msg] {
  not input.resource.aws_route_table_association.nat_gateway_rt_association.subnet_id
  msg = "Subnet not declared"
}

deny[msg] {
  not input.resource.aws_route_table_association.nat_gateway_rt_association.route_table_id
  msg = "Route table not assigned"
}
