resource "aws_lb_target_group" "private-target-group" {
  name     = "private-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ada_vpc.id
}

resource "aws_lb_target_group_attachment" "private-instances" {
  for_each         = toset(data.aws_instances.running_instances.ids)
  target_group_arn = aws_lb_target_group.private-target-group.arn
  target_id        = each.value
  port             = 80
}

resource "aws_lb" "tg-ada" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app-ada.id]
  subnets            = [aws_subnet.private-a.id, aws_subnet.private-b.id, aws_subnet.private-c.id]

  enable_deletion_protection = false

  tags = {
    Environment = "dev"
    Name = "load-balancer"
  }
}