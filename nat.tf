resource "aws_eip" "nat_gateway_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "NAT Gateway"
  }

  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_route_table" "nat_gateway_rt" {

  vpc_id = aws_vpc.vpc_petclinic.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "Route Table for NAT Gateway"
  }

  depends_on = [
    aws_nat_gateway.nat_gateway
  ]

}

resource "aws_route_table_association" "nat_gateway_rt_association" {

  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.nat_gateway_rt.id

  depends_on = [
    aws_route_table.nat_gateway_rt
  ]
}
