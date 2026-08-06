output "security_group_id" {
  type = string
  value = aws_security_group.hello_security_group.id
}