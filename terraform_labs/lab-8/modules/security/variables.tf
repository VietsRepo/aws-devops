variable "vpc_id" {
  type = string
  default = "VPC IP custom"
}

variable "inbound_range" {
  type        = string
  description = "Your ip address (ipv4). Ex: 42.112.225.144/32"
  validation {
    condition     = can(cidrhost(var.inbound_range, 0)) && endswith(var.inbound_range, "/32")
    error_message = "Ibound Range must be a valid cirdr (ipv4). Ex: 42.112.225.144/32"
  }
}