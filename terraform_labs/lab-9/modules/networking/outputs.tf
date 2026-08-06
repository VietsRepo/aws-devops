output "vpc_id" {
  type = string
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  type = string
  value = aws_subnet.public_subnet_1.id
}