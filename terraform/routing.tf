resource "aws_route_table" "web" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Net rules"
  }
}


resource "aws_route_table" "nat-a" {
  vpc_id = aws_vpc.main.id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.nat_gw_host1.id
    }


  tags = {
    Name = "Nat-a rules"
  }
}


resource "aws_route_table" "nat-b" {
  vpc_id = aws_vpc.main.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw_host2.id
  }

  tags = {
    Name = "Nat-b rules"
  }
}




resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.host1-private.id
  route_table_id = aws_route_table.nat-a.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.host2-private.id
  route_table_id = aws_route_table.nat-b.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.host1-public.id
  route_table_id = aws_route_table.web.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.host2-public.id
  route_table_id = aws_route_table.web.id
}