data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ec2-a" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.app-ada.id]
  subnet_id              = aws_subnet.private-a.id

  tags = {
    Name = "ec2-a"
  }
}

resource "aws_instance" "ec2-b" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.app-ada.id]
  subnet_id              = aws_subnet.private-b.id

  tags = {
    Name = "ec2-b"
  }
}

resource "aws_instance" "ec2-c" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.app-ada.id]
  subnet_id              = aws_subnet.private-c.id

  tags = {
    Name = "ec2-c"
  }
}