variable "aws_region" { type = string }
variable "aws_profile" { type = string}
variable "ami_id" { type = string } 
variable "instance_type" { type = string }

variable "public_subnets" {
  type = list(object({ cidr = string, az = string }))
}
variable "asg_name" { type = string }
variable "min_size" { type = number }
variable "max_size" { type = number }
variable "desired_capacity" { type = number }

variable "vpc_cidr" { type = string }
variable "vpc_name" { type = string }
variable "key_name" { type = string }
variable "internet_cidr" {
  type    = string
  default = "0.0.0.0/0"
}
variable "allowed_ssh_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "allowed_http_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "allowed_egress_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "private_subnets" {
  type = list(object({ cidr = string, az = string }))
}
variable "db_name" { type = string }
variable "db_username" { type = string }
variable "db_password" {
  type      = string
  sensitive = true
}
variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}
