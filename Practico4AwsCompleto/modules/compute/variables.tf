variable "name" { type = string }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "ami_id" { type = string }
variable "instance_type" { type = string }
variable "key_name" { type = string }
variable "target_group_arns" { type = list(string) }
variable "alb_security_group_id" { type = string }
variable "min_size" { type = number }
variable "max_size" { type = number }
variable "desired_capacity" { type = number }
variable "allowed_ssh_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "allowed_egress_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "db_host" { type = string }
variable "db_name" { type = string }
variable "db_username" { type = string }
variable "db_password" {
  type      = string
  sensitive = true
}
