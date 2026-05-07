output "alb_dns_name" {
  value = module.alb.dns_name
}

output "asg_name" {
  value = module.compute.asg_name
}

output "rds_endpoint" {
  value = module.rds.endpoint
}
