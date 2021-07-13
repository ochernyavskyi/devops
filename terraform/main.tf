provider "aws" {
  region = var.region
}


resource "aws_instance" "host1" {
  instance_type = "t2.micro"
  ami = data.aws_ami.latest_ubuntu.id
  user_data = base64encode("${file("install_nginx.sh")}")
  security_groups = [
    aws_security_group.allow_http_https.id]
  lifecycle {
    create_before_destroy = true
  }
  subnet_id = aws_subnet.host1-private.id
  tags = {
    Name = "Host1"
  }
}


resource "aws_instance" "host2" {
  instance_type = "t2.micro"
  ami = data.aws_ami.latest_ubuntu.id
  user_data = base64encode("${file("install_nginx.sh")}")
  security_groups = [
    aws_security_group.allow_http_https.id]
  lifecycle {
    create_before_destroy = true
  }
  subnet_id = aws_subnet.host2-private.id
  tags = {
    Name = "Host2"
  }
}
