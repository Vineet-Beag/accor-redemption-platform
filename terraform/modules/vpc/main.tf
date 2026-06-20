resource "aws_vpc" "main" {

  cidr_block = "10.0.0.0/16"

  enable_dns_support = true

  enable_dns_hostnames = true


  tags = {

    Name = "accor-vpc"

  }

}


# Get available AWS Availability Zones

data "aws_availability_zones" "available" {}


# Public Subnets - ALB Layer

resource "aws_subnet" "public" {

  count = 2

  vpc_id = aws_vpc.main.id


  cidr_block = cidrsubnet(
    aws_vpc.main.cidr_block,
    8,
    count.index
  )


  availability_zone = data.aws_availability_zones.available.names[count.index]


  map_public_ip_on_launch = true


  tags = {

    Name = "public-subnet-${count.index}"

  }

}


# Private Subnets - EKS Worker Nodes

resource "aws_subnet" "private" {

  count = 2

  vpc_id = aws_vpc.main.id


  cidr_block = cidrsubnet(
    aws_vpc.main.cidr_block,
    8,
    count.index + 10
  )


  availability_zone = data.aws_availability_zones.available.names[count.index]


  tags = {

    Name = "private-subnet-${count.index}"

  }

}
resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id


  tags = {

    Name = "accor-igw"

  }

}
resource "aws_eip" "nat" {

  domain = "vpc"


  tags = {

    Name = "accor-nat-eip"

  }

}
resource "aws_nat_gateway" "main" {

  allocation_id = aws_eip.nat.id

  subnet_id = aws_subnet.public[0].id


  tags = {

    Name = "accor-nat"

  }


  depends_on = [
    aws_internet_gateway.main
  ]

}
resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id


  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.main.id

  }


  tags = {

    Name = "public-route-table"

  }

}
resource "aws_route_table_association" "public" {

  count = 2


  subnet_id = aws_subnet.public[count.index].id


  route_table_id = aws_route_table.public.id

}
resource "aws_route_table" "private" {

  vpc_id = aws_vpc.main.id


  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.main.id

  }


  tags = {

    Name = "private-route-table"

  }

}
resource "aws_route_table_association" "private" {

  count = 2


  subnet_id = aws_subnet.private[count.index].id


  route_table_id = aws_route_table.private.id

}
