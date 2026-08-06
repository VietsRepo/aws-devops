output "instance_public_dns" {
  type  = string
  value = module.compute.instance_public_dns
}