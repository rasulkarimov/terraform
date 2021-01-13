provider "aws" {
  region = "eu-north-1"
  profile = "rasul.karimov"
}
resource "aws_instance" "myinstance" {
  count = 1
  ami = "ami-02cb52d7ba9887a93"
  instance_type = "t3.micro"
  key_name = "rasul-key-stolckholm"
  security_groups = [ "ssh-http-https" ]


  tags = {
    Name = "httpserver"
    app = "servers"
  }
}
