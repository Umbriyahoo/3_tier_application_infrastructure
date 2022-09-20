resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "WebAppTest"
    Demo = "Terraform"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 1)
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "Subnet1"
    Type = "Public"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 2)
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "Subnet2"
    Type = "Public"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 3)
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "Web1"
    Type = "Private"
  }
}

resource "aws_subnet" "subnet4" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 4)
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "Web2"
    Type = "Private"
  }
}

resource "aws_subnet" "subnet5" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 5)
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "DB1"
    Type = "Private"
  }
}

resource "aws_subnet" "subnet6" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 6)
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "DB2"
    Type = "Private"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name" = "InternetGateway"
  }
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.subnet1.id

  tags = {
    Name = "NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public"
  }
}

resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "Private"
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_route_table_association" "rta3" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.rt2.id
}

resource "aws_route_table_association" "rta4" {
  subnet_id      = aws_subnet.subnet4.id
  route_table_id = aws_route_table.rt2.id
}

resource "aws_route_table_association" "rta5" {
  subnet_id      = aws_subnet.subnet5.id
  route_table_id = aws_route_table.rt2.id
}

resource "aws_route_table_association" "rta6" {
  subnet_id      = aws_subnet.subnet6.id
  route_table_id = aws_route_table.rt2.id
}