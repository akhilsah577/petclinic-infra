resource "aws_internet_gateway" "internet_gateway" {

  vpc_id = aws_vpc.vpc_petclinic

  tags = {
    Name = "${var.prefix}-internet-gateway"
  }

}

resource "aws_route_table" "ig_route_table" {

  vpc_id = aws_vpc.vpc_petclinic.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name        = "${var.prefix}-public-route"
    Owner       = var.owner
    Description = "Public route table for Internet Gateway"
  }
}

resource "aws_route_table_association" "ig_route_table_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.ig_route_table.id
}
