variable "prefix" {
	type        = string
	description = "The name tag assigned to the VPC"
}

variable "vpc_cidr" {
	type        = string
	description = "CIDR block for the VPC"
}

variable "owner" {
	type        = string
	description = "Owner"
}

variable "region" {
	type 	    = string
	description = "AWS region"
}
