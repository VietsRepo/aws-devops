provider "aws" {
  region = var.region
}

# Tạo theo luồng kiến thức cái nào cần có trước
# và vì một đích học tập và tiết kiệm chi phí nên không tạo nhiều resource hơn
# chỉ tạo tổi thiếu, thực tế recommend từ aws thì nên tạo theo kiểu high availability

# 1. VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true # to enable public dns for instance
  enable_dns_hostnames = true

  tags = {
    Name: "vpc_created_by_terraform"
  }
}

# 2. Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw_created_by_terraform"
  }
}

# 3. Subnet
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.az_1
  map_public_ip_on_launch = true # to enable public ip for instance

  tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = var.az_1

  tags = {
    Name = "private_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = var.az_2

  tags = {
    Name = "public_subnet_2"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = var.az_2

  tags = {
    Name = "private_subnet_2"
  }
}

# 4. Elastic IP. Vì tạo NAT Gateway nên phải cần thằng này
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name: "Nat Elastic IP"
  }
}

# 5. NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.public_subnet_1.id

  tags = {
    Name: "Nat Gateway"
  }
}

# 6. Route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "private_route_table"
  }
}

# 7. Route table association
resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}