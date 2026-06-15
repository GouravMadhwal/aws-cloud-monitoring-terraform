resource "aws_vpc" "custom_vpc" {
  cidr_block = var.cidr
  tags = {
    Name = "Custom-VPC"
  }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.custom_vpc.id
    cidr_block = var.public_cidr
    availability_zone = var.public_subnet_az
    map_public_ip_on_launch = true
    tags = {
      Name = "Public-Subnet"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.custom_vpc.id
    cidr_block = var.private_cidr
    availability_zone = var.private_subnet_az
    map_public_ip_on_launch = false
    tags = {
      Name = "Private-Subnet"
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "Main-IGW"
  }
}

resource "aws_route_table" "custom_rt" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = var.route_table_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Custom-Route-Table"
  }
}

resource "aws_route_table_association" "custom_rt_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.custom_rt.id
}