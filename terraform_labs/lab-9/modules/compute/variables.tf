variable "region" {
  type = string
  nullable = false
}

variable "ami_id" {
  type        = string
  description = "AMI for create an intance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for the web server"
  default     = "t3.micro"
}

variable "key_name" {
  type = string
  description = "Public key for instance"
}

variable "security_group_ids" {
  type = list(string)
  description = "List security groups for instance"
  nullable = false
}

variable "public_subnet_id" {
  type = string
  description = "Public subnet for instance"
}