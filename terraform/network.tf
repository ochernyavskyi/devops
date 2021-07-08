resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "main"
  }
}


#-----------------------------------------------------
resource "aws_subnet" "host1-private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.10.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Private_Subnet_Host1"
  }
}

resource "aws_subnet" "host1-public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.11.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public_Subnet_Host1"
  }
}

resource "aws_subnet" "host2-private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.20.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "Private_Subnet_Host2"
  }
}

resource "aws_subnet" "host2-public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.21.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_Subnet_Host2"
  }
}

