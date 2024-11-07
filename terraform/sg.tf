resource "aws_security_group" "app-ada" {
  name        = "app-ada"
  description = "Projeto ADA"
  vpc_id      = aws_vpc.ada_vpc.id
  tags = {
    Name = "app-ada"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_web_ipv4" {
  security_group_id = aws_security_group.app-ada.id
  cidr_ipv4         = aws_vpc.ada_vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.app-ada.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}