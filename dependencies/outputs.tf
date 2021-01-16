output "webserver_instance_id" {
  value = aws_instance.webserver.id
}

output "webserver_sg_id" {
  value = aws_security_group.webserver_security.id
}

output "webserver_sg_arn" {
  value = aws_security_group.webserver_security.arn
}

output "webserver_public_ip_address" {
  value =  aws_eip.my_static_ip.public_ip
}

