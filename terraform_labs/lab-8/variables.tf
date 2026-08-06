variable "az_1" {
  type        = string
  description = "Availability Zone 1"
  default     = "us-east-1a"
}

variable "az_2" {
  type        = string
  description = "Availability Zone 2"
  default     = "us-east-1b"
}

variable "inbound_range" {
  type        = string
  description = "Your ip address (ipv4). Ex: 42.112.225.144/32"
  validation {
    condition     = can(cidrhost(var.inbound_range, 0)) && endswith(var.inbound_range, "/32")
    error_message = "Ibound Range must be a valid cirdr (ipv4). Ex: 42.112.225.144/32"
  }
}

variable "pub_key_path" {
  type        = string
  description = "A public key path for create a key-pair"
  default     = "./ssh-key-pair/key-pair.pub"
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