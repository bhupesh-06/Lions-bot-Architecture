# VPC

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = {
    Name = "${var.environment}-vpc"
  }
}


# Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-${element(var.public_subnets_cidr, count.index)}-public-subnet"
  }
}



# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnets_cidr)
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.environment}-${element(var.private_subnets_cidr, count.index)}-private-subnet"
  }
}



# Routing tables to route traffic for Public Subnet
resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-public-route-table"
  }
}


# Routing tables to route traffic for Private Subnet
resource "aws_route_table" "privateRT" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-private-route-table"
  }
}



# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.environment}-igw"
  }
}



# Elastic-IP (eip) for NAT
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# NAT
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 1 )

  tags = {
    Name = "${var.environment}-NAT-Gateway"
  }
}

resource "aws_eip" "nat_eip1" {
  domain = "vpc"
}

# NAT
resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.nat_eip1.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 2 )

  tags = {
    Name = "${var.environment}-NAT-Gateway"
  }
}


# Route for Internet Gateway
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.publicRT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}


# Route for NAT
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.privateRT.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route" "private_nat_gateway1" {
  route_table_id         = aws_route_table.privateRT.id
  destination_cidr_block = "0.0.0.0/1"
  nat_gateway_id         = aws_nat_gateway.nat1.id
}

# Subnet association for public route table
resource "aws_route_table_association" "publicRTassoc" {
  count = length(var.public_subnets_cidr)
  subnet_id = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.publicRT.id
  
}


# Subnet association for private route table
resource "aws_route_table_association" "privateRTassoc" {
  count = length(var.private_subnets_cidr)
  subnet_id = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.privateRT.id
}



