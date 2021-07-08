resource "aws_lb" "web" {
  name               = "mainLB"
  internal           = false
  load_balancer_type = "application"
//  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.host1-public.id, aws_subnet.host2-public.id]

  tags = {
    Name = "Main LB"
  }
}

#---------------------------------------------

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }
}



#---------------------------------------------
resource "aws_lb_target_group" "http" {
  name = "http-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id
  target_type = "instance"
 }

#----------------------------------------------
  resource "aws_lb_target_group_attachment" "host1" {
    target_group_arn = aws_lb_target_group.http.arn
    target_id        = aws_instance.host1.id
    port             = 80
  }

resource "aws_lb_target_group_attachment" "host2" {
  target_group_arn = aws_lb_target_group.http.arn
  target_id        = aws_instance.host2.id
  port             = 80
}

