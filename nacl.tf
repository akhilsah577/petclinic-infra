resource "aws_network_acl" "public_subnet" {
  vpc_id     = aws_vpc.vpc_petclinic.id
  subnet_ids = ["${aws_subnet.public.id}"]
}

resource "aws_network_acl" "private_subnet" {
  vpc_id     = aws_vpc.vpc_petclinic.id
  subnet_ids = ["${aws_subnet.private.id}"]
}

resource "aws_network_acl_rule" "public_nacl_ingress" {
  network_acl_id = aws_network_acl.private_subnet.id
  rule_number    = 100
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = var.vpc_cidr
}

resource "aws_network_acl_rule" "public_nacl_egress" {
  network_acl_id = aws_network_acl.private_subnet.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = var.vpc_cidr
}
