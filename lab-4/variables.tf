variable "inbound_range" {
  type        = string
  description = "Your ip address (ipv4). Ex: 42.112.225.144/32"
  validation {
    condition     = can(cidrhost(var.inbound_range, 0)) && endswith(var.inbound_range, "/32")
    error_message = "Ibound Range must be a valid cirdr (ipv4). Ex: 42.112.225.144/32"
  }
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