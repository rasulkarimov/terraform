provider "aws" {
  region = "eu-north-1"
}
resource "aws_instance" "webserver" {
  ami = "ami-02cb52d7ba9887a93"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver_security.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Rasu",
    l_name = "Karimov",
    names = ["One", "Two", "Three", "Four"]
  })
}

resource "aws_security_group" "webserver_security" {
  name        = "WebServer Sec Group"
  description = "inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
