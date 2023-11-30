variable "environment" {
  description = "Deployment Environment"
  type = string
  
}

variable "vpc_cidr" {
  description = "CIDR block of the vpc"
  type = string
}

variable "public_subnets_cidr" {
  type        = list
  description = "CIDR block for Public Subnet"
}

variable "availability_zones" {
  type        = list
  description = "AZ in which all the resources will be deployed"
}

variable "private_subnets_cidr" {
  type        = list
  description = "CIDR block for Private Subnet"
}