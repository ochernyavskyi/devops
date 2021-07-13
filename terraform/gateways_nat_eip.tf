resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

#------------------------------------------------------

resource "aws_eip" "lb-host1" {
  vpc      = true
}

resource "aws_eip" "lb-host2" {
  vpc      = true
}

#------------------------------------------------------
resource "aws_nat_gateway" "nat_gw_host1" {
  allocation_id = aws_eip.lb-host1.id
  subnet_id     = aws_subnet.host1-public.id

  tags = {
    Name = "gw NAT host1"
  }
}

resource "aws_nat_gateway" "nat_gw_host2" {
  allocation_id = aws_eip.lb-host2.id
  subnet_id     = aws_subnet.host2-public.id

  tags = {
    Name = "gw NAT host2"
  }
}
