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

resource "aws_security_group" "nat_sg" {
  name        = "${var.prefix}-sg"
  description = "Security Group for NAT Gateway"
  vpc_id      = aws_vpc.vpc_petclinic.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs

  }
  tags = {
    Owner = var.owner
  }
}
