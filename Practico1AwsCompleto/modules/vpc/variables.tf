variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "az" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "internet_cidr" {
  type    = string
  default = "0.0.0.0/0"
}
