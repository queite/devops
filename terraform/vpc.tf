resource "aws_vpc" "ada_vpc" {
  cidr_block       = var.cidr_vpc
  instance_tenancy = "default"

  tags = {
    Name = "ada"
  }
}
# Public Subnets
resource "aws_subnet" "public-a" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-a"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_subnet" "public-b" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "public-b"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_subnet" "public-c" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "public-c"
  }
  depends_on = [aws_vpc.ada_vpc]
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.ada_vpc.id

  tags = {
    Name = "main-gw"
  }
}
# Public route tables and associations
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.ada_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public-b" {
  subnet_id      = aws_subnet.public-b.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public-c" {
  subnet_id      = aws_subnet.public-c.id
  route_table_id = aws_route_table.public.id
}

# Private Subnets
resource "aws_subnet" "private-a" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-a"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_subnet" "private-b" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-b"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_subnet" "private-c" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "private-c"
  }
  depends_on = [aws_vpc.ada_vpc]
}
resource "aws_nat_gateway" "nat-gw-a" {
  allocation_id = aws_eip.nat_eip_a.id
  subnet_id     = aws_subnet.public-a.id

  tags = {
    Name = "NAT-a"
  }

  depends_on = [aws_internet_gateway.gw]
}
resource "aws_nat_gateway" "nat-gw-b" {
  allocation_id = aws_eip.nat_eip_b.id
  subnet_id     = aws_subnet.public-b.id

  tags = {
    Name = "NAT-b"
  }

  depends_on = [aws_internet_gateway.gw]
}
resource "aws_nat_gateway" "nat-gw-c" {
  allocation_id = aws_eip.nat_eip_c.id
  subnet_id     = aws_subnet.public-c.id

  tags = {
    Name = "NAT-c"
  }
  depends_on = [aws_internet_gateway.gw]
}
resource "aws_eip" "nat_eip_a" {

}
resource "aws_eip" "nat_eip_b" {

}
resource "aws_eip" "nat_eip_c" {

}
# Private route table and associations
resource "aws_route_table" "private-route-table-a" {
  vpc_id = aws_vpc.ada_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-a.id
  }

  tags = {
    Name = "private-route-table-a"
  }
}
resource "aws_route_table" "private-route-table-b" {
  vpc_id = aws_vpc.ada_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-b.id
  }

  tags = {
    Name = "private-route-table-b"
  }
}
resource "aws_route_table" "private-route-table-c" {
  vpc_id = aws_vpc.ada_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-c.id
  }

  tags = {
    Name = "private-route-table-c"
  }
}
resource "aws_route_table_association" "private-a" {
  subnet_id      = aws_subnet.private-a.id
  route_table_id = aws_route_table.private-route-table-a.id
}
resource "aws_route_table_association" "private-b" {
  subnet_id      = aws_subnet.private-b.id
  route_table_id = aws_route_table.private-route-table-b.id
}
resource "aws_route_table_association" "private-c" {
  subnet_id      = aws_subnet.private-c.id
  route_table_id = aws_route_table.private-route-table-c.id
}
# DB
resource "aws_subnet" "subnet-db-a" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet-db-a"
  }
  depends_on = [aws_vpc.ada_vpc]
}
resource "aws_subnet" "subnet-db-b" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.8.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "subnet-db-b"
  }
  depends_on = [aws_vpc.ada_vpc]
}
resource "aws_subnet" "subnet-db-c" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.9.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "subnet-db-c"
  }
  depends_on = [aws_vpc.ada_vpc]
}
resource "aws_route_table" "db" {
  vpc_id = aws_vpc.ada_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "db-route-table"
  }
}
resource "aws_route_table_association" "db-a" {
  subnet_id      = aws_subnet.subnet-db-a.id
  route_table_id = aws_route_table.db.id
}
resource "aws_route_table_association" "db-b" {
  subnet_id      = aws_subnet.subnet-db-b.id
  route_table_id = aws_route_table.db.id
}
resource "aws_route_table_association" "db-c" {
  subnet_id      = aws_subnet.subnet-db-c.id
  route_table_id = aws_route_table.db.id
}