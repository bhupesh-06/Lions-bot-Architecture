# VPC
resource "aws_vpc" "vpc1" {
  cidr_block           = var.vpc1_cidr
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
  tags = {
    Name = "${var.environment1}-vpc"
  }
}


# Public subnet
resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.vpc1.id
  count                   = length(var.public_subnets_cidr1)
  cidr_block              = element(var.public_subnets_cidr1, count.index)
  availability_zone       = element(var.availability_zones1, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment1}-${element(var.public_subnets_cidr1, count.index)}-public-subnet"
  }
}



# Private Subnet
resource "aws_subnet" "private_subnet1" {
  vpc_id                  = aws_vpc.vpc1.id
  count                   = length(var.private_subnets_cidr1)
  cidr_block              = element(var.private_subnets_cidr1, count.index)
  availability_zone       = element(var.availability_zones1, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.environment1}-${element(var.private_subnets_cidr1, count.index)}-private-subnet"
  }
}



# Routing tables to route traffic for Public Subnet
resource "aws_route_table" "publicRT1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "${var.environment1}-public-route-table"
  }
}


# Routing tables to route traffic for Private Subnet
resource "aws_route_table" "privateRT1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "${var.environment1}-private-route-table"
  }
}



# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "ig1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "${var.environment1}-igw"
  }
}



# Elastic-IP (eip) for NAT
resource "aws_eip" "nat_eip1" {
  domain = "vpc"
}

# NAT
resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.nat_eip1.id
  subnet_id     = element(aws_subnet.public_subnet1.*.id, 1 )

  tags = {
    Name = "${var.environment1}-NAT-Gateway"
  }
}

resource "aws_eip" "nat_eip11" {
  domain = "vpc"
}

# NAT
resource "aws_nat_gateway" "nat11" {
  allocation_id = aws_eip.nat_eip11.id
  subnet_id     = element(aws_subnet.public_subnet1.*.id, 2 )

  tags = {
    Name = "${var.environment1}-NAT-Gateway"
  }
}


# Route for Internet Gateway
resource "aws_route" "public_internet_gateway1" {
  route_table_id         = aws_route_table.publicRT1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig1.id
}


# Route for NAT
resource "aws_route" "private_nat_gateway1" {
  route_table_id         = aws_route_table.privateRT1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat1.id
}

resource "aws_route" "private_nat_gateway11" {
  route_table_id         = aws_route_table.privateRT1.id
  destination_cidr_block = "0.0.0.0/1"
  nat_gateway_id         = aws_nat_gateway.nat11.id
}

# Subnet association for public route table
resource "aws_route_table_association" "publicRTassoc1" {
  count = length(var.public_subnets_cidr1)
  subnet_id = element(aws_subnet.public_subnet1.*.id, count.index)
  route_table_id = aws_route_table.publicRT1.id
  
}


# Subnet association for private route table
resource "aws_route_table_association" "privateRTassoc1" {
  count = length(var.private_subnets_cidr1)
  subnet_id = element(aws_subnet.private_subnet1.*.id, count.index)
  route_table_id = aws_route_table.privateRT1.id
}



