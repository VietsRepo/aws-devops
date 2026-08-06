variable "security_group_ids" {
  type = list(string)
  description = "List security groups for instance"
  nullable = false
}

variable "public_subnet_id" {
  type = string
  description = "Public subnet for instance"
}

variable "key_name" {
  type = string
  description = "Public key for instance"
}

variable "ami_id" {
  type        = string
  description = "AMI for create an intance"
  default     = "ami-02b64aa047cb5edf5"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for the web server"
  default     = "t3.micro"
}
