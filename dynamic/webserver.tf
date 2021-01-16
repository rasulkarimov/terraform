provider "aws" {
  region = "eu-north-1"
}

resource "aws_security_group" "webserver_security" {
  name        = "Dynamic Security Group"

  dynamic "ingress" {
    for_each = ["80", "443", "8080"]
    content {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      }
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
  Name = "Web Server Security Group"
  Owner = "Rasul Karimov"
  }
}
