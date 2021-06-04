resource "aws_vpc" "vpc_petclinic" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true

  tags = {
    Name  = var.prefix
    Owner = var.owner

  }
}
