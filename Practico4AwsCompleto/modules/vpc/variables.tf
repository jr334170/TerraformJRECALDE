variable "vpc_cidr" { type = string }
variable "vpc_name" { type = string }
variable "internet_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "public_subnets" {
  type = list(object({ cidr = string, az = string }))
}

variable "private_subnets" {
  type = list(object({ cidr = string, az = string }))
}
