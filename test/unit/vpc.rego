package main

deny[msg] {
	not input.resource.aws_vpc.vpc_petclinic
	msg = "VPC not defined"
}


deny[msg] {

	not contains(input.resource.aws_vpc.vpc_petclinic.cidr_block, "var.vpc_cidr")
	msg = "VPC missing  CIDR block variable `var.vpc_cidr`"
}

deny[msg] {

	not input.resource.aws_vpc.vpc_petclinic.tags.Name
	msg = "VPC missing tag `Name`"
}
