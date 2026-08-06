variable "security_group_ids" {
  type = list(string)
  description = "List security groups for instance"
  nullable = false
}

variable "key_name" {
  type = string
  description = "public key for instaince"
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
