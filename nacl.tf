resource "aws_network_acl" "public_subnet" {
  vpc_id     = aws_vpc.vpc_petclinic.id
  subnet_ids = ["${aws_subnet.public.id}"]
}

resource "aws_network_acl" "private_subnet" {
  vpc_id     = aws_vpc.vpc_petclinic.id
  subnet_ids = ["${aws_subnet.private.id}"]
}

resource "aws_network_acl_rule" "private_nacl_ingress_http" {
  network_acl_id = aws_network_acl.private_subnet.id
  rule_number    = 300
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.vpc_cidr
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "private_nacl_egress_all" {
  network_acl_id = aws_network_acl.private_subnet.id
  rule_number    = 400
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.vpc_cidr
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "public_nacl_ingress_http" {
  network_acl_id = aws_network_acl.public_subnet.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "public_nacl_egress_all" {
  network_acl_id = aws_network_acl.public_subnet.id
  rule_number    = 200
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}
