output "instance_public_dns" {
  type = string
  value = aws_instance.ec2_instance.public_dns
}