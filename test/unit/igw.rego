package main

deny[msg] {
  not input.resource.aws_internet_gateway.internet_gateway
  msg = "Internet Gateway not declared"
}

deny[msg] {
  not input.resource.aws_route_table.ig_route_table
  msg = "Route Table not declared"
}

deny[msg] {
  not input.resource.aws_route_table_association.ig_route_table_association
  msg = "Route table association not declared"
}

deny[msg] {
  not input.resource.aws_route_table.ig_route_table.vpc_id
  msg = "VPC not assigned to route table"
}

deny[msg] {
  not re_match("0.0.0.0/0", input.resource.aws_route_table_association.ig_route_table.route.cidr_block)
  msg = "Public route not assigned to route table"
}

deny[msg] {
  not input.resource.aws_route_table_association.ig_route_table_association.subnet_id
  msg = "Route table association subnet not declared"
}

deny[msg] {
  not input.resource.aws_route_table_association.ig_route_table_association.route_table_id
  msg = "Route table not assigned to association"
}
