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
