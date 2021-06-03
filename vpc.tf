resource "aws_vpc" "vpc_petclinic" {
	cidr_block = var.vpc_cidr

	tags = {
	  Name = var.prefix
	  Owner = var.owner

	}
}
