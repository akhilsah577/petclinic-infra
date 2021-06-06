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

resource "aws_security_group" "web_sg" {
  name        = "${var.prefix}-web-sg"
  vpc_id      = aws_vpc.vpc_petclinic.id
  description = "Security group for the Web instance"

  tags = {
    Name = "Web Security Group"
  }
}

resource "aws_security_group_rule" "web_sg_ingress" {
  description       = "Inbound rule to allow traffic from LB to instance listener and provide health check"
  security_group_id = aws_security_group.web_sg.id
  type              = "ingress"

  from_port = 80
  to_port   = 80

  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_elb_sg.id

}

resource "aws_security_group_rule" "web_sg_egress" {
  description = "Outbound rule for the Web instance"

  security_group_id        = aws_security_group.web_sg.id
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.web_elb_sg.id
}

resource "aws_security_group" "mgmt_sg" {
  name        = "${var.prefix}-mgmt-sg"
  vpc_id      = aws_vpc.vpc_petclinic.id
  description = "Security Group for the Management instance"

  tags = {
    Name = "Management Security Group"
  }
}


resource "aws_security_group_rule" "mgmt_sg_ingress" {
  description       = "Inbound rule to allow traffic from LB to instance listener"
  security_group_id = aws_security_group.mgmt_sg.id
  type              = "ingress"

  from_port = 80
  to_port   = 80

  protocol                 = "tcp"
  source_security_group_id = aws_security_group.mgmt_elb_sg.id

}

resource "aws_security_group_rule" "mgmt_sg_egress" {
  description              = "Outbound rule for the Management instance"
  security_group_id        = aws_security_group.mgmt_sg.id
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.mgmt_elb_sg.id
}

resource "aws_security_group" "web_elb_sg" {
  name        = "${var.prefix}-web-elb-sg"
  vpc_id      = aws_vpc.vpc_petclinic.id
  description = "Security Group for Web ELB"

  tags = {
    Name = "Web ELB Security Group"
  }
}

resource "aws_security_group_rule" "web_elb_sg_ingress" {
  description       = "Inbound rule to allow traffic from VPC to LB listener"
  security_group_id = aws_security_group.web_elb_sg.id
  type              = "ingress"

  from_port = 8080
  to_port   = 8080

  protocol    = "tcp"
  cidr_blocks = ["${var.vpc_cidr}"]

}

resource "aws_security_group_rule" "web_elb_sg_egress_app" {
  description       = "Outbound rule to allow traffic from LB to instance and health check"
  security_group_id = aws_security_group.web_elb_sg.id
  type              = "egress"

  from_port = 80
  to_port   = 80

  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_sg.id

}

resource "aws_security_group_rule" "web_elb_sg_egress_all" {
  description              = "Outbound rule for the Web ELB"
  security_group_id        = aws_security_group.web_elb_sg.id
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.nat_sg.id
}


resource "aws_security_group" "mgmt_elb_sg" {
  name        = "${var.prefix}-mgmt-elb-sg"
  vpc_id      = aws_vpc.vpc_petclinic.id
  description = "Security Group for Management ELB"

  tags = {
    Name = "Management ELB Security Group"
  }
}

resource "aws_security_group_rule" "mgmt_elb_sg_ingress" {
  description       = "Inbound rule to allow all traffic on LB listener"
  security_group_id = aws_security_group.mgmt_elb_sg.id
  type              = "ingress"

  from_port = 8000
  to_port   = 8000

  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "mgmt_elb_sg_egress_srv" {
  description       = "Inbound rule to allow outbound traffic on the instance listener"
  security_group_id = aws_security_group.mgmt_elb_sg.id
  type              = "egress"

  from_port = 80
  to_port   = 80

  protocol                 = "tcp"
  source_security_group_id = aws_security_group.mgmt_sg.id

}

resource "aws_security_group_rule" "mgmt_elb_sg_egress_all" {
  description       = "Outbound rule for the Management ELB"
  security_group_id = aws_security_group.mgmt_elb_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
