resource "aws_lb_target_group" "target_group" {
  name     = "MyTargetGroup2"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}
