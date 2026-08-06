output "intance_ip" {
  type  = string
  value = aws_instance.ec2_instance.public_ip
}