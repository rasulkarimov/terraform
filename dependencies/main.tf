provider "aws" {
  region = "eu-north-1"
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.webserver.id
}


resource "aws_instance" "webserver" {
  ami = "ami-02cb52d7ba9887a93"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver_security.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Rasul",
    l_name = "Karimov",
    names = ["One", "Two", "Three", "Four", "John"]
  })
  tags = {
  Name = "Web Server Build By Terraform"
  Owner = "Rasul Karimov"
  }
  lifecycle {
    create_before_destroy = true 
    ignore_changes = ["ami", "instance_type"]
    prevent_destroy = false
  }
  depends_on = ["aws_instance.webserver_app", "aws_instance.webserver_db"]
}

resource "aws_instance" "webserver_app" {
  ami = "ami-02cb52d7ba9887a93"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver_security.id]
  tags = {
  Name = "Server-APP"
  }
  depends_on = ["aws_instance.webserver_db"]
}

resource "aws_instance" "webserver_db" {
  ami = "ami-02cb52d7ba9887a93"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver_security.id]
  tags = {
  Name = "Server-DB"
  }
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

