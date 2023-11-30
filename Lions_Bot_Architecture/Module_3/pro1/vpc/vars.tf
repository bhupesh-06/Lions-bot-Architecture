variable "environment1" {
  description = "Deployment Environment"
  type = string
}

variable "vpc1_cidr" {
  description = "CIDR block of the vpc"
  type = string
}

variable "public_subnets_cidr1" {
  type        = list
  description = "CIDR block for Public Subnet"
}

variable "availability_zones1" {
  type        = list
  description = "AZ in which all the resources will be deployed"
}

variable "private_subnets_cidr1" {
  type        = list
  description = "CIDR block for Private Subnet"
}
