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
  type        = string
  description = "AWS region"
}

variable "chef_server_version" {
  type        = string
  description = "Chef Server Version"
}

variable "chef_admin_username" {
  type        = string
  description = "Chef Admin Username"
}

variable "chef_admin_first_name" {
  type        = string
  description = "Chef Admin First Name"
}

variable "chef_admin_last_name" {
  type        = string
  description = "Chef Admin Last Name"
}

variable "chef_admin_email" {
  type        = string
  description = "Chef Admin Email Address"
}

variable "chef_admin_password" {
  type        = string
  description = "Password for Chef Admin User"
  sensitive   = true
}

variable "chef_validator_file_name" {
  type        = string
  description = "Organization validator file for Chef Server"

}

variable "chef_organization_name" {
  type        = string
  description = "Chef Default Organization Name"
}

variable "jenkins_java_version" {
  type        = string
  description = "Java JDK version for Jenkins master"
}

variable "app_java_version" {
  type        = string
  description = "Java Version for Spring Boot Application"
}

variable "allowed_cidrs" {
  type        = list(string)
  description = "Allowed IPs for SSH"
}
