resource "aws_security_group" "sg" {
  name = "Dynamic Security Group"
  description = "Allow http & https inbound traffic"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = {
    Name = "allow_all_traffic"
  }
}
